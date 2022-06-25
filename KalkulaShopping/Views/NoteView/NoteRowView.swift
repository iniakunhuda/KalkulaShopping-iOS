////
////  NoteRowView.swift
////  KalkulaShopping
////
////  Created by Miftahul Huda on 09/05/22.
////
//
//import SwiftUI
//
//struct NoteRowView: View {
//    @State var note: Note
//    
//    @State var isDetailOpen: Bool = false
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(note.name)
//                        .font(.body)
//                        .fontWeight(.bold)
//                    
//                    Text(note.date.formatted(date: .long, time: .shortened))
//                        .font(.caption)
//                        .opacity(0.6)
//                    
//                    Text(note.totalInRupiah(nominal: note.total))
//                        .font(.caption)
//                        .padding(.top, 5)
//                }
//                
//                Spacer()
//                
//                Button(action: {
//                    isDetailOpen = true
//                }, label: {
//                    Image(systemName: "chevron.right")
//                        .foregroundColor(.white)
//                })
//            }
//        }
//        .padding()
//        .fullScreenCover(isPresented: $isDetailOpen) {
//            DetailNoteView(note: note)
//        }
//    }
//}
//
//struct NoteRowView_Previews: PreviewProvider {
//    static var notes = ModelData().notes
//    
//    static var previews: some View {
//        NoteRowView(note: notes[0])
//    }
//}
