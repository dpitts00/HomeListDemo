//
//  MenuItemDetailsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI
import CoreData
import Combine

struct MenuItemDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) var editMode
    
    @FetchRequest(fetchRequest: Ingredient.ingredientsByName)
    var allIngredients: FetchedResults<Ingredient>
    
    @ObservedObject var item: MenuItem
    
    let incrementPublisher = PassthroughSubject<IngredientQty, Never>()
    
    @State var name: String = ""
    @State var meal: SelectableValue?
    @State var ingredients: [IngredientQty] = []
    @State var priceTier: SelectableValue?
    
    @State var ingredientText: String = ""
    @State var possibleMatches: [Ingredient] = []

    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Name", text: $name)
                }
                
                Section("Ingredients") {
                    ForEach(ingredients) { item in
                        IngredientQtyItemView(
                            quantity: Int(item.quantity),
                            item: item,
                            incrementPublisher: incrementPublisher
                        )
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            StorageProvider.shared.delete(ingredients[index])
                        }
                        
                        ingredients.remove(atOffsets: indexSet)
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            TextField("Add an ingredient", text: $ingredientText)
                            
                            Button{
                                saveIngredient(named: ingredientText)
                            } label: {
                                Text("Add")
                            }
                            .tint(ingredientText.isEmpty ? .gray : .blue)
                        }
                        
                        ForEach(possibleMatches, id: \.self) { item in
                            Button {
                                saveIngredientQty(for: item, in: self.item)
                            } label: {
                                Text(item.name ?? "")
                            }
                            .buttonStyle(.plain)
                            .foregroundStyle(.blue)
                        }
                    }
                }
                
                Section {
                    Picker("Meal", selection: $meal) {
                        ForEach(MenuItem.selectableMealValues, id: \.self) { meal in
                            Text(meal.displayName)
                                .tag(meal, includeOptional: true)
                        }
                    }
                    
                    Picker("Price", selection: $priceTier) {
                        ForEach(MenuItem.selectablePriceTierValues, id: \.self) { price in
                            Text(price.displayName)
                                .tag(price, includeOptional: true)
                        }
                    }
                }
            }
            .task(id: item) {
                name = item.name ?? ""
                ingredients = item.ingredients?.sortedArray(using: [NSSortDescriptor(keyPath: \IngredientQty.ingredient?.name, ascending: true)]) as? [IngredientQty] ?? []
                meal = MenuItem.selectableMealValues.first(where: { $0.rawValue == item.meal })
                priceTier = MenuItem.selectablePriceTierValues.first(where: { $0.rawValue == String(item.priceTier) })
            }
            .onChange(of: ingredientText) { _, newValue in
                if newValue.isEmpty {
                    possibleMatches = []
                } else {
                    let matches = allIngredients
                        .filter { $0.name?.localizedCaseInsensitiveContains(ingredientText) ?? false }
                        .prefix(3)
                    
                    possibleMatches = Array(matches)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .destructive) {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        updateItem()
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
    }
}

extension MenuItemDetailsView {
    func updateItem() {
        item.name = name
        item.meal = meal?.rawValue
        item.priceTier = Int16(Int(priceTier?.rawValue ?? "1") ?? 1)
        
        StorageProvider.shared.updateMenuItems()
    }
    
    func saveIngredient(named name: String) {
        if !name.isEmpty {
            if let ingredient = allIngredients.first(where: { $0.name == name }) {
                if let ingredientQty = ingredients.first(where: { $0.ingredient == ingredient }) {
                    incrementPublisher.send(ingredientQty)
                    return
                } else {
                    saveIngredientQty(for: ingredient, in: item)
                    return
                }
            }
            
            if let ingredient = StorageProvider.shared.saveIngredient(named: name) {
                saveIngredientQty(for: ingredient, in: item)
                ingredientText = ""
            }
        }
    }
    
    func saveIngredientQty(for ingredient: Ingredient, in menuItem: MenuItem) {
        if let index = ingredients.firstIndex(where:  { $0.ingredient == ingredient }) {
            let ingredientQty = ingredients[index]
            incrementPublisher.send(ingredientQty)
            // will update() when quantity changes in the list item
            ingredientText = ""
            ingredients = menuItem.ingredientQtysArray
        } else {
            if let ingredientQty = StorageProvider.shared.saveIngredientQty(for: ingredient) {
                menuItem.addToIngredients(ingredientQty)
                StorageProvider.shared.update()

                ingredientText = ""
                ingredients = menuItem.ingredientQtysArray
            }
        }
    }
}

#Preview {
    @Previewable
    @State var item = StorageProvider.shared.getAllMenuItems()[0]
    
    MenuItemDetailsView(item: item)
        .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext)
}
