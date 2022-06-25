////
////  EditNoteView.swift
////  KalkulaShopping
////
////  Created by Miftahul Huda on 13/05/22.
////
//
//import SwiftUI
//
//struct EditNoteView: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//        
//    @EnvironmentObject var modelData: ModelData
//    @StateObject var noteModel = NoteViewModel()
//    
//    @State var note: Note
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                
//                    
//                VStack(alignment: .leading, spacing: 5) {
//                    Text("Store Name")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                        
//                    TextField("", text: $note.name)
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 5)
//                        .accessibilityLabel("Input store address here")
//                }
//                Divider()
//                
//                VStack(alignment: .leading, spacing: 5) {
//                    Text("Store Address")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                        
//                    TextField("", text: $note.address)
//                        .frame(maxWidth: .infinity)
//                        .padding(.top, 10)
//                        .accessibilityLabel("Input store address here")
//                }
//                .padding(.top, 10)
//                Divider()
//                
//                
//                VStack(alignment: .leading, spacing: 5) {
//                    Text("Date")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                        
//                    Text(note.date.formatted(date: .abbreviated, time: .omitted) + ", " + note.date.formatted(date: .omitted, time: .shortened))
//                        .font(.callout)
//                        .padding(.top, 8)
//                        .accessibilityLabel(noteModel.date.formatted(date: .abbreviated, time: .omitted) + ", " + noteModel.date.formatted(date: .omitted, time: .shortened))
//                }
//                .padding(.top, 10)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .overlay(alignment: .bottomTrailing) {
//                    Button {
//                        noteModel.showDatePicker.toggle()
//                    } label: {
//                        Image(systemName: "calendar")
//                            .foregroundColor(.white)
//                            .accessibilityLabel("Click to change date order")
//                    }
//                }
//                .onTapGesture {
//                    noteModel.showDatePicker.toggle()
//                }
//                Divider()
//                
//                Spacer()
//                
//            }
//            .padding()
//            .navigationTitle("Edit Note")
//            .toolbar(content: {
//                
//                ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarLeading, content: {
//                    Button(action: {
//                        self.presentationMode.wrappedValue.dismiss()
//                    }, label: {
//                        Text("Cancel")
//                    })
//                })
//                
//                ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing, content: {
//                    Button(action: {
//                        let result = modelData.update(
//                            note_id: note.id,
//                            name: note.name,
//                            address: note.address,
//                            date: note.date
//                        )
//                        
//                        if result {
//                            self.presentationMode.wrappedValue.dismiss()
//                        }
//                    }, label: {
//                        Text("Update")
//                    })
//                })
//            })
//            
//            
//            .overlay {
//                ZStack {
//                    if noteModel.showDatePicker {
//                        Rectangle()
//                            .fill(.ultraThinMaterial)
//                            .ignoresSafeArea()
//                            .onTapGesture(perform: {
//                                noteModel.showDatePicker = false
//                            })
//                        
//                        DatePicker.init("", selection: $note.date, in: Date.now...Date.distantFuture)
//                            .datePickerStyle(.graphical)
//                            .labelsHidden()
//                            .padding()
//                            .background(.black, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
//                            .padding()
//                    }
//                }
//                .animation(.easeInOut, value: noteModel.showDatePicker)
//            }
//        }
//        .environment(\.colorScheme, .dark)
//    }
//}
//
//struct EditNoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditNoteView(note: ModelData().notes[0])
//            .environmentObject(ModelData())
//    }
//}
