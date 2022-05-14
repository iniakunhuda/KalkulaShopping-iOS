//
//  NoteViewModel.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 09/05/22.
//

import Foundation

class ModelData: ObservableObject {
    @Published var notes: [Note] = []
    
    init() {
        getNotes()
    }
    
    func getNotes() {
        let newNotes = [
                Note(
                    name: "Superindo A",
                    address: "Ach. Yani",
                    date: Date(),
                    total: 25000,
                    isActive: true,
                    items: [
                        Item(name: "Item 1", subtotal: 10000),
                        Item(name: "Item 2", subtotal: 15000)
                    ],
                    tax: 0
                ),
                Note(
                    name: "Superindo B",
                    address: "Kenjeran",
                    date: Date(),
                    total: 25000,
                    isActive: false,
                    items: [
                        Item(name: "Item 1", subtotal: 10000),
                        Item(name: "Item 2", subtotal: 15000)
                    ],
                    tax: 0
                ),
                Note(
                    name: "Superindo C",
                    address: "Setro Baru",
                    date: Date(),
                    total: 25000,
                    isActive: false,
                    items: [
                        Item(name: "Item 1", subtotal: 10000),
                        Item(name: "Item 2", subtotal: 15000)
                    ],
                    tax: 0
                ),
        ]
        notes.append(contentsOf: newNotes)
    }
    
    private func recountTotal(note_id: String) {
        if let idxNote = notes.firstIndex(where: { $0.id == note_id }) {
            var total: Float = 0
            for item in notes[idxNote].items {
                total += item.subtotal
            }
            notes[idxNote].total = total
        }
    }
    
    func closeNote(note_id: String) {
        if let idxNote = notes.firstIndex(where: { $0.id == note_id }) {
            notes[idxNote].isActive = false
        }
    }
    
    func create(name: String, address: String, date: Date) -> Bool {
        notes.append(
            Note(
                name: name,
                address: address,
                date: date,
                total: 0,
                isActive: true,
                items: [],
                tax: 0
            )
        )
        return true
    }
    
    func update(note_id: String, name: String, address: String, date: Date) -> Bool {
        if let idxNote = notes.firstIndex(where: { $0.id == note_id }) {
            notes[idxNote].name = name
            notes[idxNote].address = address
            notes[idxNote].date = date
            return true
        }
        return false
    }
    
    func addItem(note_id: String, item: Item) -> Bool {
        if let idxNote = notes.firstIndex(where: { $0.id == note_id }) {
            notes[idxNote].items.append(item)
            self.recountTotal(note_id: note_id)
            return true
        }
        return false
    }
    
    func updateItem(note_id: String, item: Item) -> Bool {
        if let idxNote = notes.firstIndex(where: { $0.id == note_id }) {
            if let idxItem = notes[idxNote].items.firstIndex(where: { $0.id == item.id }) {
                notes[idxNote].items[idxItem] = item
                self.recountTotal(note_id: note_id)
                return true
            }
            return false
        }
        return false
    }
    
    func removeItem(note_id: String, item_id: String) -> Bool {
        if let idxNote = notes.firstIndex(where: { $0.id == note_id }) {
            let items = notes[idxNote].items
            notes[idxNote].items = items.filter{ $0.id != item_id }
            self.recountTotal(note_id: note_id)
            return true
        }
        return false
    }
    
    func getActive() -> [Note] {
        return notes.filter{ $0.isActive }
    }

    func getInActive() -> [Note] {
        return notes.filter{ !$0.isActive }
    }
    
    func getItemsByNoteId(note_id: String) -> [Item] {
        var noteIndex: Int {
            notes.firstIndex(where: { $0.id == note_id }) ?? 0
        }
        return notes[noteIndex].items
    }
}
