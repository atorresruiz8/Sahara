//
//  Product+CoreDataProperties.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/21/21.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: String?
    @NSManaged public var price: Double
    @NSManaged public var name: String?
    @NSManaged public var tags: NSObject?
    @NSManaged public var image: String?
    @NSManaged public var sale: Bool
    @NSManaged public var salePercentage: Double
    @NSManaged public var review: NSSet?

}

// MARK: Generated accessors for review
extension Product {

    @objc(addReviewObject:)
    @NSManaged public func addToReview(_ value: Review)

    @objc(removeReviewObject:)
    @NSManaged public func removeFromReview(_ value: Review)

    @objc(addReview:)
    @NSManaged public func addToReview(_ values: NSSet)

    @objc(removeReview:)
    @NSManaged public func removeFromReview(_ values: NSSet)

}

extension Product : Identifiable {

}
