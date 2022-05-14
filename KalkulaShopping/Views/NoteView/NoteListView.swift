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
                    }
                } else {
                    Text("Click button below to start shopping")
                        .font(.caption)
                        .opacity(0.6)
                }
            }, header: {
                Text("Shopping")
            })
            
            
            Section(content: {
                ForEach(modelData.getInActive(), id: \.self) { note in
                    NoteRowView(note: note)
                        .listRowInsets(EdgeInsets())
                }
            }, header: {
                Text("History")
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
