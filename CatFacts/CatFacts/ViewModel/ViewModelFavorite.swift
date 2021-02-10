//
//  ViewModelFavorite.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 10/02/21.
//

import Foundation
import UIKit

class ViewModelFavorite {
    
    let persistenceService = CoreDataFunctions()
    var favoriteFacts: [Favorite]?
    var isFavorite: Bool = false
    //MARK:- COREDATA
    
    func save(fact: Fact) {
        persistenceService.saveFact(fact: fact)
    }
    
    func deleteItem(id: UUID) {
        persistenceService.delete(id: id)
    }
    
    func getAll() -> [Favorite] {
        return persistenceService.getAll()
    }
}
