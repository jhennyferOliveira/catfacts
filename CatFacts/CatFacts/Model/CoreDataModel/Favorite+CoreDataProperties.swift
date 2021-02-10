//
//  Favorite+CoreDataProperties.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 09/02/21.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var favoriteText: String?

}

extension Favorite : Identifiable {

}
