//
//  Review+CoreDataProperties.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/21/21.
//
//

import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var comment: String?
    @NSManaged public var rating: Bool
    @NSManaged public var user: User?
    @NSManaged public var product: Product?

}

extension Review : Identifiable {

}
