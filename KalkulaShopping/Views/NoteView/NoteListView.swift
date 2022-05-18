//
//  NoteListView.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 09/05/22.
//

import SwiftUI

struct NoteListView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        List {
            Section(content: {
                if(modelData.getActive().count > 0) {
                    ForEach(modelData.getActive(), id: \.self) { note in
                        NoteRowView(note: note)
                            .listRowInsets(EdgeInsets())
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("Note from \(note.name) at \(note.date) with total \(note.total). Click to view detail")
                    }
                }
            }, header: {
                Text("Shopping")
                    .accessibilityLabel("New Shopping Section")
            })
            
            
            Section(content: {
                ForEach(modelData.getInActive(), id: \.self) { note in
                    NoteRowView(note: note)
                        .opacity(0.6)
                        .listRowInsets(EdgeInsets())
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("Note from \(note.name) at \(note.date) with total \(note.total). Click to view detail")
                }
            }, header: {
                Text("History")
                    .accessibilityLabel("History Shopping Section")
            })
        }
        .listStyle(.insetGrouped)
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView()
            .environmentObject(ModelData())
    }
}
