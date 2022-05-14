//
//  NewNoteView.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 09/05/22.
//

import SwiftUI

struct NewNoteView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
    @EnvironmentObject var modelData: ModelData
    @StateObject var noteModel = NoteViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                Form {
                    
                    Section(content: {
                        
                        TextField(text: $noteModel.name, prompt: Text("Name"), label: {
                            Text("Name")
                        })
                        TextField(text: $noteModel.address, prompt: Text("Address"), label: {
                            Text("Address")
                        })
                        DatePicker("Date", selection: $noteModel.date, in: ...Date())
                        
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
                        let result = modelData.create(
                            name: noteModel.name,
                            address: noteModel.address,
                            date: noteModel.date
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

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView()
            .environmentObject(ModelData())
    }
}
