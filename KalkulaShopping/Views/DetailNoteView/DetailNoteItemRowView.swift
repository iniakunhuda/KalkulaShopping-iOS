//
//  DetailNoteItemRowView.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 11/05/22.
//

import SwiftUI

struct DetailNoteItemRowView: View {
    
    var note: Note
    
    @State var item: Item
    @State var isEdited: Bool = true
    @State var isEditClicked: Bool = false
    
    var body: some View {
        let itemModel = ItemViewModel()
        return VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.title2)
                    
                    Text(String(item.formatRupiah(nominal: item.subtotal)))
                        .opacity(0.5)
                }
                Spacer()
                
                if(isEdited) {
                    Button(action: {
                        itemModel.item = item
                        print("ITEM EDIT:", item)
                        
                        self.isEditClicked = true
                    }, label: {
                        Image(systemName: "pencil")
                    })
                }
            }
        }
        .padding()
        .fullScreenCover(isPresented: $isEditClicked) {
            AddItemView(isEditMode: true, itemModel: itemModel, note: note)
        }
    }
}

struct DetailNoteItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNoteItemRowView(
            note: ModelData().notes[0],
            item: Item(name: "Item 1", subtotal: 10000)
        )
    }
}
