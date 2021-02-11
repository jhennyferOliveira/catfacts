//
//  test.swift
//  CatFactsTests
//
//  Created by Jhennyfer Rodrigues de Oliveira on 11/02/21.
//

import XCTest
@testable import CatFacts
import CoreData

class test: XCTestCase {
    
    var sut: CoreDataFunctions?
    
    override func setUp() {
        sut = CoreDataFunctions(container: mockPersistantContainer)
    }
    
    func testSaveFact() {
        let totalFactsBeforeSaving = sut?.getAll(context: mockPersistantContainer.viewContext)
        let fact = Fact(fact: "some fact", length: 200)
        sut?.saveFact(fact: fact, context: mockPersistantContainer.viewContext)
        do {
            try mockPersistantContainer.viewContext.save()
        }  catch {
            print("create fakes error \(error)")
        }
        let totalFactsAfterSaving = sut?.getAll(context: mockPersistantContainer.viewContext)
        
        guard let totalFactsBefore = totalFactsBeforeSaving else {return}
        guard let totalFactsAfter = totalFactsAfterSaving else {return}
        XCTAssertEqual(totalFactsBefore.count, totalFactsAfter.count - 1)
        
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
    
}
