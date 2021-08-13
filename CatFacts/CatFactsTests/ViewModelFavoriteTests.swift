//
//  ViewModelFavoriteTests.swift
//  CatFactsTests
//
//  Created by Jhennyfer Rodrigues de Oliveira on 12/02/21.
//

import XCTest
import CoreData
@testable import CatFacts

class ViewModelFavoriteTests: XCTestCase {

    var sut: ViewModelFavorite?
    
    func testSave() {
        sut = ViewModelFavorite()
        let fact = Fact(fact: "fact 1", length: 12)
        sut?.save(fact: fact, context: mockPersistantContainer.viewContext)
        let allFacts = sut?.getAll(context: mockPersistantContainer.viewContext)
        guard let facts = allFacts else {return}
        for item in facts {
            if item.favoriteText == fact.fact {
                XCTAssertTrue(item.favoriteText == fact.fact)
            }
          
        }
        
    }
    
    func testGet() {
        sut = ViewModelFavorite()
        guard let factsBeforeSaving = sut?.getAll(context: mockPersistantContainer.viewContext) else {return}
        let fact = Fact(fact: "fact 2", length: 12)
        sut?.save(fact: fact, context: mockPersistantContainer.viewContext)
        guard let factsAfterSaving = sut?.getAll(context: mockPersistantContainer.viewContext) else {return}
        
        XCTAssertTrue(factsAfterSaving.count == factsBeforeSaving.count + 1)
        
    }
    
    func testDelete() {
        sut = ViewModelFavorite()
        
        let fact = Fact(fact: "fact 3", length: 12)
        sut?.save(fact: fact, context: mockPersistantContainer.viewContext)
        guard let factsBeforeDeleting = sut?.getAll(context: mockPersistantContainer.viewContext) else {return}
        for item in factsBeforeDeleting {
            if item.favoriteText == fact.fact {
                guard let id = item.id else {return}
                sut?.deleteItem(id: id, context: mockPersistantContainer.viewContext)
            }
        }
        
        guard let factsAfterDeleting = sut?.getAll(context: mockPersistantContainer.viewContext) else {return}
        
        XCTAssertTrue(factsAfterDeleting.count == factsBeforeDeleting.count - 1 )
    }
    
    //MARK: mock in-memory persistant store
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CatFacts", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
    
    func saveInContextMock() {
        do {
            try mockPersistantContainer.viewContext.save()
        }  catch {
            print("create fakes error \(error)")
        }
    }
    

}

