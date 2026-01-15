//
//  IngredientsListView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/12/26.
//

import SwiftUI

struct IngredientsListView: View {
    @Environment(\.editMode) var editMode
    
    @State var ingredients = StorageProvider.shared.getAllIngredients()
    @State var ingredientText = ""
    
    @Binding var path: NavigationPath

    var body: some View {
        List {
            Section("All Ingredients") {
                ForEach(ingredients) { item in
                    Button {
                        path.append(item)
                    } label: {
                        Text(item.name ?? "")
                    }
                    .deleteDisabled(editMode?.wrappedValue.isEditing ?? true)
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        StorageProvider.shared.delete(ingredients[index])
                    }
                    
                    ingredients.remove(atOffsets: indexSet)
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
        .navigationDestination(for: Ingredient.self) { ingredient in
            IngredientDetailView(ingredient: ingredient)
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
    @Previewable
    @State var path = NavigationPath()
    
    NavigationStack(path: $path) {
        IngredientsListView(path: $path)
    }
}
