//
//  ContentView.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 28/04/22.
//

// TODO: ada error, ketika edit note -> save -> edit note lg datanya ga berubah

import SwiftUI

struct HomeView: View {
    @State private var isNavigateToNewNote = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollViewReader { scroll in
                    VStack(alignment: .leading) {
                        NoteListView()
                    }
                    .frame(minHeight: 900)
                }
            }
            .overlay(alignment: .bottom) {
                // MARK: Add button
                Button {
                    self.isNavigateToNewNote = true
                } label: {
                    Label {
                        Text("Create New Note")
                            .font(.callout)
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "plus.app.fill")
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(.blue, in: Capsule())
                }
                
                // MARK: Gradient
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
//                .background{
//                    LinearGradient(colors: [
//                        .white.opacity(0.05),
//                        .white.opacity(0.4),
//                        .white.opacity(0.7)
//                    ], startPoint: .top, endPoint: .bottom)
//                    .ignoresSafeArea()
//                }
                .accessibilityLabel("Click to create New Note")
                
            }
            .navigationTitle("Shopping Note")
        }
        .environment(\.colorScheme, .dark)
        .fullScreenCover(isPresented: $isNavigateToNewNote) {
            NewNoteView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ModelData())
    }
}
