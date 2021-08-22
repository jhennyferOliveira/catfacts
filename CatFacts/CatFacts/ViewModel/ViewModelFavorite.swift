//
//  ViewModelFavorite.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 10/02/21.
//

import Foundation
import UIKit
import CoreData

class ViewModelFavorite {
    
    static let sharedInstance = ViewModelFavorite()
    let persistenceService = DataPersistenceOperator(container: AppDelegate.persistentContainer)
    var favoritedFacts: [Favorite]?
    var currentFactIsFavorite: Bool = false
    
    //MARK:- COREDATA
    
    func save(fact: Fact, context: NSManagedObjectContext = AppDelegate.viewContext ) {
        _ = persistenceService.saveFact(fact: fact, context: context)
    }
    
    func deleteItem(id: UUID, context: NSManagedObjectContext = AppDelegate.viewContext) {
        persistenceService.delete(id: id, context: context)
    }
    
    func getAll(context: NSManagedObjectContext = AppDelegate.viewContext) -> [Favorite] {
        return persistenceService.getAll(context: context)
    }
}
