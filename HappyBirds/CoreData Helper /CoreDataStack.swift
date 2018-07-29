//
//  CoreDataStack.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/22/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HappyBirds")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext { return persistentContainer.viewContext }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addToFavorites(quote: Quote) {
        guard let favDesc = NSEntityDescription.entity(forEntityName: "Favorite", in: context) else { return }
        let favorite = NSManagedObject(entity: favDesc, insertInto: context)
        favorite.setValue(Date(), forKey: "dateAdded")
        favorite.setValue(quote.quote, forKey: "text")
        favorite.setValue(quote.author, forKey: "author")
        try? context.save()
    }
    
    func favorite(for quote: Quote) -> Favorite? {
        let request = NSFetchRequest<Favorite>(entityName: "Favorite")
        request.predicate = NSPredicate(format: "text == %@", quote.quote ?? "")
        guard let results = try? context.fetch(request) else { return nil }
        return results.first
    }
    
    func deleteFromFavorites(quote: Quote) {
        guard let favorite = favorite(for: quote) else { return }
        context.delete(favorite)
        try? context.save()
    }
}
