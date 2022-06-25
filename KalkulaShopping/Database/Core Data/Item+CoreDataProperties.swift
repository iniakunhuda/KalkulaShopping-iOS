//
//  Item+CoreDataProperties.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 30/05/22.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var category: String?
    @NSManaged public var discountType: NSObject?
    @NSManaged public var discountValue: Float
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var price: Int16
    @NSManaged public var priceType: ItemPriceType?
    @NSManaged public var quantity: Int16
    @NSManaged public var subtotal: Float
    @NSManaged public var weight: Float
    @NSManaged public var weightUnit: ItemWeightUnit?
    
//    @NSManaged public var priceTypeValue: String?
//    var priceType: ItemPriceType {
//        set {
//            self.priceTypeValue = newValue.rawValue
//        }
//        get {
//            return ItemPriceType(rawValue: self.priceTypeValue!) ?? ItemPriceType.Fixed
//        }
//    }

}

extension Item : Identifiable {

}
