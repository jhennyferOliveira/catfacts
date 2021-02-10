//
//  ViewModel.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 05/02/21.
//

import Foundation
import UIKit

class ViewModel {
    let service = APIHandler()
    let persistenceService = CoreDataFunctions()
    
//    var fact: Fact? {
//        didSet {
//            self.collectionView = controller.collectionView
//            self.collectionView?.reloadData()
//        }
//    }
    var fact: Fact?
    var favoriteFacts: [Favorite]?
    
    //MARK:- API
    func getFact(completionHandler: @escaping (Fact) -> Void) {
        service.getDataFromAPI(completionHandler: completionHandler)
    }
    
    //MARK:- COREDATA
    
    func save(fact: Fact) {
        persistenceService.saveFact(fact: fact)
    }
    
    func getAll() -> [Favorite] {
        return persistenceService.getAll()
    }
}
