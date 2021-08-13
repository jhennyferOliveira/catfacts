//
//  CoreDataFunctions.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 09/02/21.
//

import Foundation
import CoreData

public class CoreDataFunctions {
    
    let context = AppDelegate.viewContext
    
    init(container: NSPersistentContainer = AppDelegate.persistentContainer) {
    }
    
    func save(){
        do {
            try context.save()
        } catch {
            print("Save error \(error)")
        }
    }
    
    func saveFact(fact: Fact, context: NSManagedObjectContext = AppDelegate.viewContext  ) -> Favorite {
        guard let object = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: context) as? Favorite else { return Favorite()}
        object.id = UUID()
        object.favoriteText = fact.fact
        save()
        return object
    }
    

    func delete(id: UUID, context: NSManagedObjectContext = AppDelegate.viewContext ) {
        let favorites = getAll(context: context)
        for favorite in favorites {
            if favorite.id == id {
                context.delete(favorite)
                save()
            }
            
        }
    }
    
    func getAll(context: NSManagedObjectContext = AppDelegate.viewContext ) -> [Favorite] {
        guard let favorites: [Favorite] = try? context.fetch(Favorite.fetchRequest()) else {
            return []
        }
        return favorites
    }
    
}
