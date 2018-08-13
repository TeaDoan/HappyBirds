//
//  JokesViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/22/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit
import CoreData

class JokesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    lazy var fetchedResultsController: NSFetchedResultsController<Favorite> = {
        let request = NSFetchRequest<Favorite>(entityName: "Favorite")
        let sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: CoreDataStack.shared.context,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        return frc
    }()
    
    
    struct Contants {
        static let jokeCellIdentifier = "jokeCell"
    }
    private var jokes : [Joke] = []
    var loaedIndexPath : IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
      try? fetchedResultsController.performFetch()
       tableView.delegate = self
       tableView.dataSource = self
    let textAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    navigationController?.navigationBar.titleTextAttributes = textAttributes
   NotificationCenter.default.addObserver(self, selector: #selector(handleFavortieButton), name: .favoriteHasDeleted , object: nil )
        fetchJokes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      tableView.reloadData()
    }
// MARK - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
// MARK - IBActions
    
// MARK - TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Contants.jokeCellIdentifier, for: indexPath) as! JokesTableViewCell
        let jokeAtIndexPath = jokes[indexPath.row]
        self.tableView.separatorStyle = .none
        cell.jokeLabel.text = jokeAtIndexPath.joke
        cell.detailTextLabel?.text = "Unknown"
        cell.jokeLabel.textAlignment = .center
        cell.delegate = self
        cell.favoriteButton.isSelected = jokeAtIndexPath.isFavorite ?? false
        DispatchQueue.main.async {
            cell.formatRoundedViewIfNeeded()
        }
        return cell
    }
    
// MARK - Methods
    func fetchJokes() {
        JokeAPIService.fetchJokes { (joke) in
            guard let joke = joke else {return}
            DispatchQueue.main.async {
                joke.forEach { $0.isFavorite = self.existsInCoreData(joke : $0) }
                self.jokes = joke
                self.tableView.reloadData()
            }
        }
    }
    
    func existsInCoreData(joke: Joke) -> Bool {
        let favorites = self.fetchedResultsController.fetchedObjects ?? []
        return favorites.contains(where:{ $0.text == joke.joke })
    }
    
    @objc func handleFavortieButton(notification: Notification) {
        guard let info = notification.userInfo,
            let text = info["text"] as? String else {return}
        jokes.filter { $0.joke == text }.forEach {
            $0.isFavorite = false
        }
        tableView.reloadData()
    }
}

extension JokesViewController: FavoriteJokeButtonClickDelegate {
    func didSet(cell: JokesTableViewCell, isFavorite: Bool) {
        guard let path = tableView.indexPath(for: cell)?.row else { return }
        let joke = jokes[path]
        joke.isFavorite = isFavorite
        if isFavorite {
            CoreDataStack.shared.addJokesToFavrites(joke:joke)
        } else {
            CoreDataStack.shared.deleteJokeFromFavorites(for:joke)
        }
    }
}


 


