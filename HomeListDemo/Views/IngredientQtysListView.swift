//
//  IngredientQtysListView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/12/26.
//


import SwiftUI

struct IngredientQtysListView: View {
    @State var ingredientQtys = StorageProvider.shared.getAllIngredientQtys()
    @State var ingredients = StorageProvider.shared.getAllIngredients()

    var body: some View {
        List {
            Section("Ingredients") {
                ForEach(ingredientQtys) { item in
                    HStack {
                        Text(item.ingredient?.name ?? "")
                        Spacer()
                        Text("\(item.quantity)")
                    }
                    // use LabeledContent instead
                }
            }
            
            Section("All Ingredients") {
                ForEach(ingredients) { ingredient in
                    Button {
                        saveIngredientQty(for: ingredient)
                    } label: {
                        HStack {
                            Text(ingredient.name ?? "")
                            
                            Spacer()
                            
                            Image(systemName: "plus")
                        }
                    }
                    .contentShape(Rectangle())
                }
                
            }
            
            Section {
                Button(role: .destructive) {
                    StorageProvider.shared.deleteAllIngredientQtys()
                    ingredientQtys = StorageProvider.shared.getAllIngredientQtys()
                } label: {
                    Text("Delete all?")
                }
            }
        }
    }
}

extension IngredientQtysListView {
    // TODO: this only updates UI the first time, but not after
    // using a shadow @State var for ingredients and forcing redraw of the list
    func saveIngredientQty(for ingredient: Ingredient) {
        if let index = ingredientQtys.firstIndex(where:  { $0.ingredient == ingredient }) {
            ingredientQtys[index].quantity += 1
            StorageProvider.shared.update()
            ingredientQtys = StorageProvider.shared.getAllIngredientQtys()
        } else {
            StorageProvider.shared.saveIngredientQty(for: ingredient)
            ingredientQtys = StorageProvider.shared.getAllIngredientQtys()
        }
    }
}

#Preview {
    IngredientQtysListView()
}
