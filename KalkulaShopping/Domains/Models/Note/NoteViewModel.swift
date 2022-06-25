//
//  NoteViewModel.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 09/05/22.
//

import Foundation
import SwiftUI
import CoreData

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
    
    @Published var showDatePicker: Bool = false
    
    // MARK: Edit note properties
    @Published var editNote: Note?
}

extension NoteViewModel {
    
    func addNote(context: NSManagedObjectContext) -> Bool {
        // MARK: Update existing data
        var note: Note!
        if let editNote = editNote {
            note = editNote
        } else {
            note = Note(context: context)
        }
        
        note.address = address
        note.date = date
        note.name = name
        note.tax = tax
        note.total = total
        note.isActive = true
        
        if let _ = try? context.save() {
            return true
        }
        return false
    }
    
}
