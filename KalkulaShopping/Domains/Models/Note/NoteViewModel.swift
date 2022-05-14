//
//  NoteViewModel.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 09/05/22.
//

import Foundation
import SwiftUI

enum Validation {
    case success
    case failure(message: String)
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
}

class NoteViewModel: Identifiable, ObservableObject {
    @Published var id: String = UUID().uuidString
    @Published var name: String = ""
    @Published var address: String = ""
    @Published var date: Date = Date()
    @Published var total: Float = 0
    @Published var isActive: Bool = false
    @Published var items: [Item] = []
    @Published var tax: Float = 0
}
