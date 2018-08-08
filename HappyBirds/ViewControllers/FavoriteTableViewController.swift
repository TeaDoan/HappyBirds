//
//  FavoriteTableViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/26/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import CoreData
import UIKit

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
        let textAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0, green: 0.8651906848, blue: 0.6215168834, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        try? fetchedResultsController.performFetch()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorite", for: indexPath) as! FavoriteTableViewCell
        let favorite = fetchedResultsController.object(at: indexPath)
         let whiteRoundedView : UIView = UIView(frame: CGRect(x: 20, y: 18, width: self.view.frame.size.width - 40, height: 170))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        tableView.separatorStyle = .none
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 8.0
        whiteRoundedView.layer.masksToBounds = true
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        whiteRoundedView.applyGradient(colours:[UIColor.rgb(71, 207, 171),UIColor.rgb(56, 207, 150)] )
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        cell.bodyTextLabel.text = favorite.text
        cell.detailLabel.text = favorite.author ?? "Unknown"
        return cell
    }
    
    // MARK - TableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let contentToDeleleAtIndexPath = fetchedResultsController.fetchedObjects?[indexPath.row] {
                 CoreDataStack.shared.delete(item: contentToDeleleAtIndexPath)
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
        tableView.reloadData()
//        self.tableView.endUpdates()
    }
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//    }
    
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

