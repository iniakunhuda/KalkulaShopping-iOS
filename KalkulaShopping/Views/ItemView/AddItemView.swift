//
//  ItemView.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 28/04/22.
//

import SwiftUI
import Combine

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
          case true: self.hidden()
          case false: self
        }
    }
}

struct AddItemView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var isEditMode: Bool = false
    
    @ObservedObject var itemModel: ItemViewModel
    @EnvironmentObject var modelData: ModelData
    
    @State var note: Note
    @State private var isPriceFloat: Bool = false
    
    @State private var priceLabel = "Price"
    @State private var weightLabel = "Weight Minimal"
    @State private var quantityLabel = "Quantity"
    
    @State private var isAlertShow = false
    @State private var alertErrorMessage = ""
    
//    private func calcSubtotal() {
//        self.subtotal = itemModel.formatRupiah(nominal: itemModel.calculateSubtotal())
//    }
    
    func priceTypeChanged() {
        self.isPriceFloat = itemModel.isPriceFloat()
        
        itemModel.setDefault()
        itemModel.calculateSubtotal()
        
        if(self.isPriceFloat) {
            self.weightLabel = "Weight Minimal (ex: 100gr)"
            self.priceLabel = "Price per Weight (ex: 3000 / 100 gr)"
            self.quantityLabel = "Quantity (ex: buy 1000 gr)"
        } else {
            self.priceLabel = "Price"
            self.quantityLabel = "Quantity"
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Form {
                        Section (header:
                            Text("Item")
                        ) {
                            TextField(text: $itemModel.item.name, prompt: Text("Name"), label: {
                                Text("Name")
                            })
                                .accessibilityLabel("Input item name")
                            
                            Picker("Category", selection: $itemModel.item.category) {
                                ForEach(ItemCategoriesList, id: \.self) {
                                    Text($0)
                                }
                            }
                            .accessibilityLabel("Category selected \(itemModel.item.category). Click to edit here")
                        }
                        
                        
                        Section (header:
                            Text("Price & Quantity")
                        ) {
                            
                            Picker("Price Type", selection: $itemModel.item.priceType) {
                                ForEach(ItemPriceType.allCases, id: \.self) { value in
                                    Text(value.rawValue)
                                }
                            }.onChange(of: itemModel.item.priceType) { val in
                                self.priceTypeChanged()
                            }
                            .accessibilityLabel("Price Type selected \(itemModel.item.priceType.rawValue). Click to edit here")
                            
                            if(isPriceFloat) {
                                Picker("Weight Unit", selection: $itemModel.item.weightUnit) {
                                    ForEach(ItemWeightUnit.allCases, id: \.self) { value in
                                        Text(value.rawValue)
                                    }
                                }
                                .accessibilityLabel("Weight Unit selected \(itemModel.item.weightUnit.rawValue). Click to edit here")
                                
                                TextField(self.weightLabel, text: $itemModel.item.weight, onEditingChanged: { changed in
                                    itemModel.calculateSubtotal()
                                })
                                .keyboardType(.numberPad)
                                .onReceive(Just(itemModel.item.weight)) { qty in
                                    let filtered = qty.filter { "0123456789".contains($0) }
                                    if filtered != qty {
                                        itemModel.item.weight = filtered
                                    }
                                }
                                .accessibilityLabel("Input weight here")
                                
                                
                            }
                            
                            TextField(self.priceLabel, text: $itemModel.item.price, onEditingChanged: { changed in
                                itemModel.calculateSubtotal()
                            })
                            .keyboardType(.numberPad)
                            .onReceive(Just(itemModel.item.price)) { price in
                                let filtered = price.filter { "0123456789".contains($0) }
                                if filtered != price {
                                    itemModel.item.price = filtered
                                }
                            }
                            .accessibilityLabel("Input price item here")
                            
                            TextField(self.quantityLabel, text: $itemModel.item.quantity, onEditingChanged: { changed in
                                itemModel.calculateSubtotal()
                            })
                            .keyboardType(.numberPad)
                            .onReceive(Just(itemModel.item.quantity)) { qty in
                                let filtered = qty.filter { "0123456789".contains($0) }
                                if filtered != qty {
                                    itemModel.item.quantity = filtered
                                }
                            }
                            .accessibilityLabel("Input quantity item here")
                                
                        }
                        
                        Section(content: {
                            
                            Picker("Discount Type", selection: $itemModel.item.discountType) {
                                ForEach(ItemDiscountType.allCases, id: \.self) {
                                    Text($0.rawValue)
                                }
                            }.onChange(of: itemModel.item.discountType) { val in
                                self.itemModel.item.discountValue = ""
                            }
                            .accessibilityLabel("Discount type selected \(itemModel.item.discountType.rawValue). Click to edit here")
                            
                            
                            TextField("Discount", text: $itemModel.item.discountValue, onEditingChanged: { changed in
                                itemModel.calculateSubtotal()
                            })
                            .keyboardType(.numberPad)
                            .onReceive(Just(itemModel.item.discountValue)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    itemModel.item.discountValue = filtered
                                }
                            }
                            .accessibilityLabel("Input discount item here")
                            
                        }, header: {
                            Text("Discount")
                        })
                        
                        
                        
                        Section(content: {
                            TextEditor(text: $itemModel.item.note)
                                .accessibilityLabel("Input additional note here")
                        }, header: {
                            Text("Note")
                        })
                    }
                    .frame(height:600)
                }
                
                VStack {
                    HStack {
                        Text("Subtotal")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                        
                        Text(String(itemModel.formatRupiah(nominal: itemModel.subtotal)))
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                    .padding()
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                }
                .frame(alignment: .bottom)
                
            }
            .onAppear(perform: {
                if(isEditMode) {
                    itemModel.calculateSubtotal()
                }
            })
            .navigationTitle((isEditMode) ? "Edit Item" : "Add Item")
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
                        
                        self.isAlertShow = false
                        
                        if(itemModel.isSubtotalNil()) {
                            self.isAlertShow = true
                            self.alertErrorMessage = ItemFailedMessage.InsuffientBalance.rawValue
                            return
                        }
                        
                        // MARK: Edit Data
                        let res: Bool
                        if(isEditMode) {
                            res = modelData.updateItem(
                                note_id: note.id,
                                item: itemModel.item
                            )
                        } else {
                            // MARK: Add Data
                            res = modelData.addItem(
                                note_id: note.id,
                                item: itemModel.item)
                        }
                        
                        if res {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    }, label: {
                        Text("Save")
                    }).alert(isPresented: $isAlertShow) {
                        Alert(title: Text("Failed Add Item"), message: Text(self.alertErrorMessage))
                    }
                    .disabled(itemModel.isFormValid())
                    
                })
                
            })
        }
        .environment(\.colorScheme, .dark)
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var notes = ModelData().notes
    
    static var previews: some View {
        AddItemView(itemModel: .init(), note: notes[0])
            .environmentObject(ModelData())
    }
}
