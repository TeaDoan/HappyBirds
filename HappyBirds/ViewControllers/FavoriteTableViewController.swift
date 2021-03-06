//
//  FavoriteTableViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/26/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import CoreData
import UIKit

extension Notification.Name {
    static let favoriteHasDeleted = Notification.Name("FavoriteHasDeleted")
}


class FavoriteTableViewController: UITableViewController {
    
    lazy var fetchedResultsController: NSFetchedResultsController<Favorite> = {
        let request = NSFetchRequest<Favorite>(entityName: "Favorite")
        let sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: CoreDataStack.shared.context,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        try? fetchedResultsController.performFetch()
       
    }
    
    //MARK: - Methods

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorite", for: indexPath) as! FavoriteTableViewCell
        let favorite = fetchedResultsController.object(at: indexPath)
        cell.bodyTextLabel.text = favorite.text
        cell.detailLabel.text = favorite.author ?? "Unknown"
        DispatchQueue.main.async {
             cell.formatContainerViewIfNeeded()
        }
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let contentToDeleleAtIndexPath = fetchedResultsController.fetchedObjects?[indexPath.row] {
        NotificationCenter.default.post(name: .favoriteHasDeleted, object: nil, userInfo: [
                    "text": contentToDeleleAtIndexPath.text!
                    ])
                CoreDataStack.shared.delete(object: contentToDeleleAtIndexPath)
            }
        }    
    }
  
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellToShare"{
            guard  let shareDestination = segue.destination as? FavoriteToShareViewController else {return}
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            guard let contenToPass = fetchedResultsController.fetchedObjects?[indexPath.row] else {return}
            shareDestination.favoriteToShare = contenToPass
        }
    }
}

extension FavoriteTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        NotificationCenter.default.post(name: .favoriteHasDeleted, object: nil)
        tableView.reloadData()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        case .move: return
        }
    }
}

