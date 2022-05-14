//
//  EditNoteView.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 13/05/22.
//

import SwiftUI

struct EditNoteView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
    @EnvironmentObject var modelData: ModelData
    @StateObject var noteModel = NoteViewModel()
    
    @State var note: Note
    
    var body: some View {
        NavigationView {
            VStack {
                
                Form {
                    
                    Section(content: {
                        
                        TextField(text: $note.name, prompt: Text("Name"), label: {
                            Text("Name")
                        })
                        
                        TextField(text: $note.address, prompt: Text("Address"), label: {
                            Text("Address")
                        })
                        DatePicker("Date", selection: $note.date, in: ...Date())
                        
                    }, header: {
                        Text("Grocery Detail")
                    })
                    
                }
                
            }
            .navigationTitle("New Note")
            .toolbar(content: {
                
                ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarLeading, content: {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                })
                
                ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing, content: {
                    Button(action: {
                        let result = modelData.update(
                            note_id: note.id,
                            name: note.name,
                            address: note.address,
                            date: note.date
                        )
                        
                        if result {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }, label: {
                        Text("Next")
                    })
                })
                
            })
        }
    }
}

struct EditNoteView_Previews: PreviewProvider {
    static var previews: some View {
        EditNoteView(note: ModelData().notes[0])
            .environmentObject(ModelData())
    }
}
