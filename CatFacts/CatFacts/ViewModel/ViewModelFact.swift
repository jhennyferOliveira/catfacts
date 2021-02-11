//
//  ViewModel.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 05/02/21.
//

import Foundation
import UIKit

class ViewModelFact {
    let service = APIHandler()
    let persistenceService = CoreDataFunctions()
    
    var fact: Fact?

    //MARK:- API
    func getFact(completionHandler: @escaping (Fact) -> Void) {
        service.getDataFromAPI(completionHandler: completionHandler)
    }
    
    //MARK:- COREDATA
    
    func save(fact: Fact) {
        _ = persistenceService.saveFact(fact: fact)
    }
    
    func deleteItem(id: UUID) {
        persistenceService.delete(id: id)
    }
    
    func getAll() -> [Favorite] {
        return persistenceService.getAll()
    }
}
