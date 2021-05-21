//
//  User+CoreDataProperties.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/21/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var address: String?
    @NSManaged public var balance: Double
    @NSManaged public var wishlist: NSObject?
    @NSManaged public var cart: NSObject?
    @NSManaged public var creditCard: NSObject?
    @NSManaged public var netBanking: NSObject?
    @NSManaged public var searchHistory: NSObject?
    @NSManaged public var profilePicture: NSObject?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var review: NSSet?
    @NSManaged public var bought: NSSet?

}

// MARK: Generated accessors for review
extension User {

    @objc(addReviewObject:)
    @NSManaged public func addToReview(_ value: Review)

    @objc(removeReviewObject:)
    @NSManaged public func removeFromReview(_ value: Review)

    @objc(addReview:)
    @NSManaged public func addToReview(_ values: NSSet)

    @objc(removeReview:)
    @NSManaged public func removeFromReview(_ values: NSSet)

}

// MARK: Generated accessors for bought
extension User {

    @objc(addBoughtObject:)
    @NSManaged public func addToBought(_ value: BoughtProduct)

    @objc(removeBoughtObject:)
    @NSManaged public func removeFromBought(_ value: BoughtProduct)

    @objc(addBought:)
    @NSManaged public func addToBought(_ values: NSSet)

    @objc(removeBought:)
    @NSManaged public func removeFromBought(_ values: NSSet)

}

extension User : Identifiable {

}
