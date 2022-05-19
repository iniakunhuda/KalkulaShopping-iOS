//
//  DetailNoteView.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 11/05/22.
//

import SwiftUI
import Combine

struct DetailNoteView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var modelData: ModelData
    
    @State var note: Note
    @State var isAddNewItem: Bool = false
    @State var isEditNote: Bool = false
    @State var items: [Item] = []
    
    var noteIndex: Int {
        modelData.notes.firstIndex(where: { $0.id == note.id }) ?? 0
    }
    
    var body: some View {
        
        let detNote = modelData.notes[noteIndex]
        
        NavigationView {
            VStack {
                
                ScrollView {
                    Form {
                        
                        
                        Section(content: {
                            
                            Group(content: {
                                HStack {
                                    Text("Name")
                                    Spacer()
                                    Text(detNote.name)
                                }
                                HStack {
                                    Text("Address")
                                    Spacer()
                                    Text(detNote.address)
                                }
                                HStack {
                                    Text("Date")
                                    Spacer()
                                    Text(detNote.date.formatted(date: .abbreviated, time: .shortened))
                                }
                            })
                            
                            if(note.isActive) {
                                Button(action: {
                                    self.isEditNote = true
                                }, label: {
                                    Text("Edit")
                                })
                                    .accessibilityLabel("Click to Edit Grocery Detail")
                            }
                            
                        }, header: {
                            Text("Grocery Detail")
                        })

                        
                        Section(content: {
                            
                            if(note.isActive) {
                                TextField("Tax (%)", value: $note.tax, formatter: NumberFormatter(), onEditingChanged: { changed in
                                    
                                })
                                .keyboardType(.numberPad)
                                .accessibilityLabel("Input Tax here")
                            } else {
                                Text(String(Float(note.tax)))
                                    .accessibilityLabel("Tax \(String(Float(note.tax))) %")
                            }

                            
                        }, header: {
                            Text("Tax (%)")
                        })
                        
                        
                        Section(content: {
                            
                            if(note.isActive) {
                                Button(action: {
                                    // goto additemview
                                    self.isAddNewItem = true
                                }, label: {
                                    Text("Add New Item")
                                })
                                    .accessibilityLabel("Click to add New Item")
                            }
                            
                            DetailNoteItemListView(
                                note: note,
                                items: modelData.getItemsByNoteId(note_id: note.id)
                            )

                        }, header: {
                            Text("List Items")
                        })

                        
                    }
                    .frame(minHeight: 600)
                }
                
                VStack {
                    HStack {
                        Text("Subtotal")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                        
                        Text(String(detNote.totalWithTax()))
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                    .padding()
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                }
                .frame(alignment: .bottom)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Subtotal \(String(detNote.totalWithTax()))")
                
            }
            .navigationTitle("Detail Note")
            .toolbar(content: {
                
                ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarLeading, content: {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Back")
                    })
                })
                
                ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing, content: {
                    Button(action: {
                        // save & close
                        modelData.closeNote(note_id: note.id)
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Text("Archive")
                    })
                        .hidden(!note.isActive)
                })
                
            })
            .fullScreenCover(isPresented: $isAddNewItem) {
                AddItemView(itemModel: ItemViewModel(), note: note)
            }
            .fullScreenCover(isPresented: $isEditNote) {
                EditNoteView(note: note)
            }
        }
        .environment(\.colorScheme, .dark)
    }
}

struct DetailNoteView_Previews: PreviewProvider {
    static var notes = ModelData().notes
    
    static var previews: some View {
        DetailNoteView(note: notes[0])
            .environmentObject(ModelData())
    }
}
