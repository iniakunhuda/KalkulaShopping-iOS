//
//  Item.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 28/04/22.
//

import Foundation

enum ItemFailedMessage: String {
    case InsuffientBalance = "Subtotal must be greater than 0"
}

@objc enum ItemPriceType: Int, CaseIterable, RawRepresentable {
    case Fixed
    case Float
    
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
            case .Fixed:
                return "Fixed"
            case .Float:
                return "Custom (Kg, Liter, etc)"
        }
    }
    
    public init?(rawValue: RawValue) {
        switch rawValue {
            case "Fixed":
                self = .Fixed
            case "Custom (Kg, Liter, etc)":
            self = .Float
            default:
                return nil
        }
    }
    
    var id: ItemPriceType { self }
}

@objc enum ItemWeightUnit: Int, CaseIterable, RawRepresentable {
    case None
    case Kg
    case Gram
    case Liters
    
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
            case .None:
                return "None"
            case .Kg:
                return "Kg"
            case .Gram:
                return "Gram"
            case .Liters:
                return "Liters"
        }
    }
    
    public init?(rawValue: RawValue) {
        switch rawValue {
            case "Fixed":
                self = .Fixed
            case "Custom (Kg, Liter, etc)":
            self = .Float
            default:
                return nil
        }
    }
    
    var id: ItemWeightUnit { self }
}

@objc enum ItemDiscountType: String, CaseIterable {
    case Fixed = "Fixed"
    case Percentage = "Percentage"
    
    var id: ItemDiscountType { self }
}

let ItemCategoriesList = [
    "Baju",
    "Makanan",
    "Minuman",
    "Kebutuhan Rumah Tangga",
    "Lainnya",
    "Pendidikan",
]

// TODO: Tipe data harga atau quantity masih string, how to convert to decimal / float?

struct ItemStruct: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var name: String = ""
    var category: String = ""
    var note: String = ""
    
    var weightUnit: ItemWeightUnit = .None
    var weight: String = ""
    
    var priceType: ItemPriceType = .Fixed
    var price: String = ""
    var quantity: String = ""

    var discountType: ItemDiscountType = .Fixed
    var discountValue: String = "" // ASK: how to convert to int?
    
    var subtotal: Float!
}

extension ItemStruct {

    func formatRupiah(nominal: Float) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        if let formatNumber = formatter.string(from: nominal as NSNumber) {
            return "Rp" + formatNumber
        }
        return String(nominal)
    }
}
