//
//  Item+CoreDataProperties.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 19/05/22.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var category: String?
    @NSManaged public var discountType: String?
    @NSManaged public var discountValue: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var price: String?
    @NSManaged public var priceType: String?
    @NSManaged public var quantity: String?
    @NSManaged public var subtotal: Float
    @NSManaged public var weight: String?
    @NSManaged public var weightUnit: ItemWeightUnit?

    var weightUnitStatus: ItemWeightUnit {
        set {
            weightUnit = ItemWeightUnit.rawValue
        }
        get {
            ItemWeightUnit(rawValue: weightUnit) ?? .None
        }
    }
}

extension Item : Identifiable {
    
}
