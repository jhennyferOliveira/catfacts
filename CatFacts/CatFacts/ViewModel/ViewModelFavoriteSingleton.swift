//
//  ViewModelFavorite.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 10/02/21.
//

import Foundation
import UIKit
import CoreData

class ViewModelFavoriteSingleton {
    
    private static var sharedViewModelFavorite = ViewModelFavoriteSingleton()
    
    let persistenceService = CoreDataFunctions(container: AppDelegate.persistentContainer)
    
    var favoriteFacts: [Favorite]? = []
    var isFavorite: Bool = false
    var favFacts: [Favorite]?

    static func getViewModelFavoriteInstance() -> ViewModelFavoriteSingleton {
        return ViewModelFavoriteSingleton.sharedViewModelFavorite
    }
    
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
