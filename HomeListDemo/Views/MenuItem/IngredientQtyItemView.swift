//
//  IngredientQtyItemView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/13/26.
//

import SwiftUI
import Combine

struct IngredientQtyItemView: View {
    @State var quantity: Int = 1

    var item: IngredientQty
    
    var incrementPublisher: PassthroughSubject<IngredientQty, Never>
    
    var body: some View {
        LabeledContent {
            HStack {
                Button{
                    if quantity > 1 {
                        quantity -= 1
                    }
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
                    Text("\(quantity)")
                }
                
                Button{
                    quantity += 1
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
        .onChange(of: quantity) { _, newValue in
            if quantity > 0 && quantity < 100 {
                item.quantity = Int32(newValue)
                StorageProvider.shared.update()
            }
        }
        .onReceive(incrementPublisher) { ingredientQty in
            if item.id == ingredientQty.id {
                quantity += 1
            }
        }
    }
}

#Preview {
    @Previewable
    @State var ingredients = StorageProvider.shared.getAllIngredientQtys()
    
    let item = ingredients[0]
    
    let publisher = PassthroughSubject<IngredientQty, Never>()
    
    IngredientQtyItemView(item: item, incrementPublisher: publisher)
}
