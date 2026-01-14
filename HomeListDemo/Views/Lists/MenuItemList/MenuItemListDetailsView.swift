//
//  MenuItemListDetailsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/8/26.
//

import SwiftUI
import CoreData

struct IngredientWithQuantity: Hashable {
    // but NOT the CoreData model
    let ingredient: Ingredient
    let quantity: Int
    
    var name: String {
        ingredient.name ?? ""
    }
}

struct MenuItemListDetailsView: View {
    var list: MenuItemList
    
    var sortedIngredients: [IngredientWithQuantity] {
        let ingredients = list.itemsArray.flatMap { $0.ingredientQtysArray }.compactMap { $0.ingredient }
        let set = NSCountedSet(array: ingredients)
        let ingredientsWithQuantityArray = set.compactMap { item in
            if let ingredient = item as? Ingredient {
                return IngredientWithQuantity(ingredient: ingredient, quantity: set.count(for: ingredient))
            } else {
                return nil
            }
        }
        return ingredientsWithQuantityArray.sorted(by: { $0.ingredient.name ?? "" < $1.ingredient.name ?? "" })
    }
    
    @State private var name: String = ""
    
    var body: some View {
        List {
            Section("Name") {
                TextField("Name", text: $name)
            }

            Section("Menu Items") {
                ForEach(list.itemsArray) { item in
                    Text(item.nameString)
                }
            }
            
            Section("All Ingredients") {
                ForEach(sortedIngredients, id: \IngredientWithQuantity.ingredient) { item in
                    LabeledContent(item.name, value: "\(item.quantity)")
                }
            }
        }
        .task(id: list) {
            name = list.name ?? ""
        }
        .onDisappear {
            list.name = name
            StorageProvider.shared.update()
        }
    }
}

#Preview {
    let lists = StorageProvider.shared.getAllMenuItemLists()
    if lists.count > 0 {
        MenuItemListDetailsView(list: lists[0])
    } else {
        Text("no lists saved")
    }
}
