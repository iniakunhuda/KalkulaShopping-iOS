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
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Store Name")
                        .font(.caption)
                        .foregroundColor(.gray)
                        
                    TextField("", text: $noteModel.name)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .accessibilityLabel("Input store address here")
                }
                Divider()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Store Address")
                        .font(.caption)
                        .foregroundColor(.gray)
                        
                    TextField("", text: $noteModel.address)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 10)
                        .accessibilityLabel("Input store address here")
                }
                .padding(.top, 10)
                Divider()
                
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Date")
                        .font(.caption)
                        .foregroundColor(.gray)
                        
                    Text(noteModel.date.formatted(date: .abbreviated, time: .omitted) + ", " + noteModel.date.formatted(date: .omitted, time: .shortened))
                        .font(.callout)
                        .padding(.top, 8)
                        .accessibilityLabel(noteModel.date.formatted(date: .abbreviated, time: .omitted) + ", " + noteModel.date.formatted(date: .omitted, time: .shortened))
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        noteModel.showDatePicker.toggle()
                    } label: {
                        Image(systemName: "calendar")
                            .foregroundColor(.white)
                            .accessibilityLabel("Click to change date order")
                    }
                }
                .onTapGesture {
                    noteModel.showDatePicker.toggle()
                }
                Divider()
                
                Spacer()
            }
            .padding()
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
            
            .overlay {
                ZStack {
                    if noteModel.showDatePicker {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                            .onTapGesture(perform: {
                                noteModel.showDatePicker = false
                            })
                        
                        DatePicker.init("", selection: $noteModel.date, in: Date.now...Date.distantFuture)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                            .padding()
                            .background(.black, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .padding()
                            .accessibilityLabel("Choose date & time")
                    }
                }
                .animation(.easeInOut, value: noteModel.showDatePicker)
            }
        }
        .environment(\.colorScheme, .dark)
    }
}

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView()
            .environmentObject(ModelData())
    }
}
