//
//  CoreDataFunctions.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 09/02/21.
//

import Foundation
import CoreData

class CoreDataFunctions {
    
    let context = AppDelegate.viewContext
    
    func save(){
        do {
            try context.save()
        } catch {
            print("Save error \(error)")
        }
    }
    
    func saveFact(fact: Fact ) {
        guard let object = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: context) as? Favorite else { return }
        object.id = UUID()
        object.favoriteText = fact.fact
        save()
    }
    

    func delete(id: UUID) {
        let favorites = getAll()
        for favorite in favorites {
            if favorite.id == id {
                context.delete(favorite)
                save()
            }
            
        }
    }
    
    func getAll() -> [Favorite] {
        guard let favorites: [Favorite] = try? context.fetch(Favorite.fetchRequest()) else {
            return []
        }
        return favorites
    }
    
}
