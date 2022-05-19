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

enum ItemPriceType: String, CaseIterable {
    case Fixed = "Fixed"
    case Float = "Custom (Kg, Liter, etc)"
    
    var id: ItemPriceType { self }
}

enum ItemWeightUnit: String, CaseIterable {
    case None = "None"
    case Kg = "Kg"
    case Gram = "Gram"
    case Liters = "Liters"
    
    var id: ItemWeightUnit { self }
}

enum ItemDiscountType: String, CaseIterable {
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
