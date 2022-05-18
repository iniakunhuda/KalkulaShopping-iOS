//
//  DetailNoteItemListView.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 11/05/22.
//

import SwiftUI

struct DetailNoteItemListView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var note: Note
    var items: [Item] = []
    
    var body: some View {
        List {
            
            ForEach(items, id: \.self) { item in
                
                DetailNoteItemRowView(
                    note: note,
                    item: item,
                    isEdited: note.isActive
                )
                .listRowInsets(EdgeInsets())
                .swipeActions(edge: .leading) {
                    
                    if(note.isActive) {
                        Button(role: .destructive) {
                            modelData.removeItem(note_id: note.id, item_id: item.id)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Item \(item.name) with price \(String(item.subtotal))" + (note.isActive ? ". Click to edit item" : ""))
                
            }
        }
    }
}

struct DetailNoteItemListView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNoteItemListView(note: ModelData().notes[0])
            .environmentObject(ModelData())
    }
}
