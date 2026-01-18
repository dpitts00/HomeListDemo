//
//  IngredientQtyItemView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/13/26.
//

import SwiftUI

struct IngredientQtyItemView: View {
    @State var quantity: Int = 1

    @ObservedObject var item: IngredientQty
    
    var body: some View {
        LabeledContent {
            HStack {
                Button{
                    handleQuantity(item.quantity - 1)
                } label: {
                    Image(systemName: "minus")
                        .contentShape(.rect)
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(.plain)

                ZStack {
                    // reserve space, use correct method later
                    Text("99")
                        .hidden()
                    Text("\(item.quantity)")
                }
                
                Button{
                    handleQuantity(item.quantity + 1)
                } label: {
                    Image(systemName: "plus")
                        .contentShape(.rect)
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(.plain)

            }
        } label: {
            Text("\(item.ingredient?.name ?? "")")
        }
    }
    
    func handleQuantity(_ quantity: Int32) {
        if quantity > 0 && quantity < 100 {
            item.quantity = quantity
            StorageProvider.shared.update()
        }
    }
}

#Preview {
    @Previewable
    @State var ingredients = StorageProvider.shared.getAllIngredientQtys()
    
    let item = ingredients[0]
    
    IngredientQtyItemView(item: item)
}
