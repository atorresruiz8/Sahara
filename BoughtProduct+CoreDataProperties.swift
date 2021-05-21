//
//  BoughtProduct+CoreDataProperties.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/21/21.
//
//

import Foundation
import CoreData


extension BoughtProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BoughtProduct> {
        return NSFetchRequest<BoughtProduct>(entityName: "BoughtProduct")
    }

    @NSManaged public var trackingStatus: String?
    @NSManaged public var price: Double
    @NSManaged public var deliveryDate: Date?
    @NSManaged public var deliverySpeed: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var owner: User?

}

extension BoughtProduct : Identifiable {

}
