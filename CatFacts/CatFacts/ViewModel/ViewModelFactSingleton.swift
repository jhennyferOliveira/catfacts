//
//  ViewModel.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 05/02/21.
//

import Foundation
import UIKit
import CoreData

public class ViewModelFactSingleton {
    
    private static let sharedViewModelFact: ViewModelFactSingleton = {
            let viewModel = ViewModelFactSingleton()
            return viewModel
    }()
    
    let service = APIHandler()
    let persistenceService = CoreDataFunctions()
    var fact: Fact?
    var isFavorite: Bool = false
    
    private init() {}
    
    static func getViewModelFactInstance() -> ViewModelFactSingleton {
        return ViewModelFactSingleton.sharedViewModelFact
    }

    //MARK:- API
    func getFact(completionHandler: @escaping (Fact) -> Void) {
        service.getDataFromAPI(completionHandler: completionHandler)
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
