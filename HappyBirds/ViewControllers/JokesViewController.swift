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
    let textAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0, green: 0.8651906848, blue: 0.6215168834, alpha: 1)]
    navigationController?.navigationBar.titleTextAttributes = textAttributes
        updateViews()
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
        tableView.backgroundColor = .clear
        cell.backgroundColor = .clear
        self.tableView.separatorStyle = .none
//        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 180))
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 20, y: 18, width: self.view.frame.size.width - 40, height: 170))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 8.0
        whiteRoundedView.layer.masksToBounds = true
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        whiteRoundedView.applyGradient(colours:[UIColor.rgb(71, 207, 171),UIColor.rgb(56, 207, 150)] )
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        cell.jokeLabel.text = jokeAtIndexPath.joke
        cell.jokeLabel.textAlignment = .center
        cell.delegate = self
        cell.favoriteButton.isSelected = jokeAtIndexPath.isFavorite ?? false
        return cell
    }
    
// MARK - TableView Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
// MARK - Methods
    func updateViews() {
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
}

extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map {$0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
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


 


