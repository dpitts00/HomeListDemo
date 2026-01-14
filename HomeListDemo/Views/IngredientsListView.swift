//
//  IngredientsListView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/12/26.
//

import SwiftUI

struct IngredientsListView: View {
    @State var ingredients = StorageProvider.shared.getAllIngredients()
    @State var ingredientText = ""

    var body: some View {
        List {
            ForEach(ingredients) { item in
                Text(item.name ?? "")
            }
            
            HStack {
                TextField("Add an ingredient", text: $ingredientText)
                    .onSubmit {
                        saveIngredient(named: ingredientText)
                    }
                
                Button {
                    saveIngredient(named: ingredientText)
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            Section {
                Button(role: .destructive) {
                    StorageProvider.shared.deleteAllIngredients()
                    ingredients = StorageProvider.shared.getAllIngredients()
                } label: {
                    Text("Delete all?")
                }
            }
        }
    }
}

extension IngredientsListView {
    func saveIngredient(named name: String) {
        if !name.isEmpty {
            StorageProvider.shared.saveIngredient(named: name)
            ingredientText = ""
            ingredients = StorageProvider.shared.getAllIngredients()
        }
    }
}

#Preview {
    IngredientsListView()
}
