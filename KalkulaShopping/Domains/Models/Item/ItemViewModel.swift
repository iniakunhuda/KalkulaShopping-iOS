//
//  ItemViewModel.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 11/05/22.
//

import Foundation
import CoreData

class ItemViewModel: Identifiable, ObservableObject {
    @Published var item: Item
    @Published var subtotal: Float = 0.0
    
    init() {
        item = Item()
    }
}


extension ItemViewModel {
    
    func isPriceFloat() -> Bool {
        return self.item.priceType == ItemPriceType.Float
    }
    
    func isSubtotalNil() -> Bool {
        return self.subtotal < 1
    }
    
    func isFormValid() -> Bool {
        let qty = Float(self.item.quantity) ?? 0
        let price = Float(self.item.price) ?? 0
        
        return self.item.quantity.isEmpty || self.item.price.isEmpty || self.item.name.isEmpty || self.item.category.isEmpty || (qty < 1) || (price < 1)
    }
    
    func setDefault() {
        self.item.price = ""
        self.item.weight = ""
        self.item.quantity = ""
        self.item.discountValue = ""
    }
    
    // actual_price = price - discount
    func getActualPrice() -> Int {
        let price: Int = Int(self.item.price) ?? 0
        let discount: Int = Int(self.item.discountValue) ?? 0
        
        return price - discount
    }
    
    func calculateSubtotal() {
        let price: Float = Float(self.item.price) ?? 0
        let weight: Float = Float(self.item.weight) ?? 0
        let discountValue: Float = Float(self.item.discountValue) ?? 0
        let quantity: Float = Float(self.item.quantity) ?? 0
        let discount: Float
        let actualPrice: Float
        var subtotal: Float = 0.0
        
        if(price < 1 || quantity < 1) {
            self.item.subtotal = 0
            self.subtotal = 0
            return
        }

        switch(self.item.priceType) {
            case ItemPriceType.Fixed:
                actualPrice = price
            case ItemPriceType.Float:
                actualPrice = (quantity/weight) * price
        }
        
        switch(self.item.discountType) {
            case ItemDiscountType.Fixed:
                discount = discountValue
            case ItemDiscountType.Percentage:
            if(self.item.priceType == ItemPriceType.Fixed) {
                    discount = (actualPrice * quantity) * (discountValue/100)
                } else {
                    discount = (actualPrice) * (discountValue/100)
                }
            }
        
        switch(self.item.priceType) {
            case ItemPriceType.Fixed:
                subtotal = (actualPrice * quantity) - discount
            case ItemPriceType.Float:
                subtotal = actualPrice - discount
        }
    
        self.subtotal = subtotal
        self.item.subtotal = subtotal
    }
    
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
