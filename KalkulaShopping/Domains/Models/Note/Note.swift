//
//  Note.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 09/05/22.
//

// https://stackoverflow.com/questions/44544387/array-of-structs-how-to-save-in-coredata

import Foundation

struct NoteStruct: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var address: String
    var date: Date
    var total: Float
    var isActive: Bool
    var items: [Item]
    var tax: Float
}

extension NoteStruct {
    
    func totalInRupiah(nominal: Float) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        if let formatNumber = formatter.string(from: nominal as NSNumber) {
            return "Rp" + formatNumber
        }
        return String(nominal)
    }
    
    func totalWithTax() -> String {
        let totalTax: Float = self.total * (self.tax / 100)
        let totalPlusTax: Float = self.total + totalTax
        
        return self.totalInRupiah(nominal: totalPlusTax)
    }
    
}


