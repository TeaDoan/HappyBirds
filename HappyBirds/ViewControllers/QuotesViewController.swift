//
//  QuotesViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/25/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import CoreData
import UIKit

class QuotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    //MARK : Properties
    var photoArray = Array(1...104).compactMap {"us\($0)"}
    var imageDictionary = [IndexPath : UIImage]()
    var randomImageIndecies = Array(0...103)
    let cellIdentifier = "quoteCell"
    private var quotes : [Quote] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        try? fetchedResultsController.performFetch()
        
        let textAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        fetchQuotes()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK : TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier , for: indexPath) as! QuotesTableViewCell
        let quoteAtIndexPath = quotes[indexPath.row]
        tableView.separatorStyle = .none
        if let image = imageDictionary[indexPath] {
            cell.backgroundView = UIImageView(image: image)
        } else {
            let rand = Int(arc4random_uniform(UInt32(randomImageIndecies.count - 1)))
            UIGraphicsBeginImageContext(cell.frame.size)
            UIImage(named:photoArray[randomImageIndecies[rand]])?.draw(in: (cell.contentView.bounds))
            randomImageIndecies.remove(at: rand)
            if randomImageIndecies.count == 0 {
                randomImageIndecies = Array(0...photoArray.count)
            }
            let imageToShow : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            imageDictionary[indexPath] = imageToShow
            cell.backgroundView = UIImageView(image: imageToShow)
            cell.backgroundView?.contentMode = .scaleAspectFit
        }
        self.tableView.separatorStyle = .none
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 10
        cell.quoteLabel.text = quoteAtIndexPath.quote
        cell.quoteLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        cell.authorLabel.text = quoteAtIndexPath.author ?? "Unknown"
        cell.favoriteButton.contentMode = .scaleAspectFill
        cell.delegate = self
        cell.favoriteButton.isSelected = quoteAtIndexPath.isFavorite ?? false
        return cell
    }
    
    //MARK : TableView Delegate
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
   }
    
    //MARK : Methods
    
    func fetchQuotes() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        QuotesAPIService.getQuotes { quotes in
        guard let quotes = quotes else {return}
        quotes.forEach { $0.isFavorite = self.existsInCoreData(quote: $0) }
        self.quotes = quotes
        dispatchGroup.leave()
        }
        dispatchGroup.enter()
        QuotesAPIService.getProgrammingQuote(completion: { (pQuote) in
            guard let pQuote = pQuote else {return}
            pQuote.forEach { $0.isFavorite = self.existsInCoreData(quote: $0) }
          self.quotes.append(contentsOf: pQuote)
            dispatchGroup.leave()
            })
        
        dispatchGroup.notify(queue: .main) {
            print("this function is getting call ")
            self.tableView.reloadData()
            
    }
}

    func existsInCoreData(quote: Quote) -> Bool {
        let favorites = self.fetchedResultsController.fetchedObjects ?? []
        return favorites.contains(where: { $0.text == quote.quote })
    }
}

extension QuotesViewController: FavoriteButtonClickDelegate {
    func didSet(cell: QuotesTableViewCell, isFavorite: Bool) {
        guard let path = tableView.indexPath(for: cell)?.row else { return }
        let quote = quotes[path]
        quote.isFavorite = isFavorite
        
        if isFavorite {
            CoreDataStack.shared.addToFavorites(quote: quote)
        } else {
            CoreDataStack.shared.deleteFromFavorites(quote: quote)
        }
    }
}
