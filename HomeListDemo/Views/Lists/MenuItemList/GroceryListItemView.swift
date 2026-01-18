//
//  GroceryListItemView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/17/26.
//

import SwiftUI
import CoreData

struct GroceryListItemView: View {
    var item: IngredientWithQuantity // cannot be @ObservedObject, but could be @Binding maybe; it's a struct though so does it matter?
    @ObservedObject var list: MenuItemList
    var selectIngredient: (Ingredient, MenuItemList) -> ()
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: item.isSelected ? "checkmark.square.fill" : "square")
                .onTapGesture {
                    selectIngredient(item.ingredient, list)
                }

            VStack(alignment: .leading) {
                LabeledContent {
                    Text("\(item.quantity)")
                } label: {
                    Text(item.name)
                }
                
                Text(item.menuItemsList)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

