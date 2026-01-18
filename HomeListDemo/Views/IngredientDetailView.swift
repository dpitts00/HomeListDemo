//
//  IngredientDetailView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/14/26.
//

import SwiftUI
import CoreData

struct IngredientDetailView: View {
    @FetchRequest(fetchRequest: IngredientType.typesByName)
    var types: FetchedResults<IngredientType>
  
//    var types = StorageProvider.shared.getAllIngredientTypes()
    
    @State var type: IngredientType?
    @State var typeText: String = ""
    
    @ObservedObject var ingredient: Ingredient
    
    var body: some View {
        List {
            Text(ingredient.name ?? "")
//            Text(ingredient.type?.name ?? "")
            Text(type?.name ?? "") // so it updates
            
            Picker("Type", selection: $type) {
                ForEach(types) { type in
                    Text(type.name ?? "")
                        .tag(type)
                }
                
                Text("Select")
                    .tag(nil as IngredientType?)
            }
            
            HStack {
                TextField("Add a new type", text: $typeText)
                Button {
                    if !typeText.isEmpty {
                        if let _ = types.firstIndex(where: { $0.name == typeText }) {
                            
                        } else {
                            StorageProvider.shared.saveIngredientType(named: typeText)
                            typeText = ""
                        }
                    }
                } label: {
//                    Image(systemName: "plus")
                    Text("Add")
                }
            }
            
            // DEBUG
            Section("testing StorageProvider fetching") {
                ForEach(StorageProvider.shared.getMenuItemsForIngredient(ingredient)) { item in
                    VStack(alignment: .leading) {
                        Text(item.name ?? "")
                        Text("\(StorageProvider.shared.getIngredientsForMenuItem(item).compactMap { $0.name }.joined(separator: ", "))")
                            .font(.caption)
                    }
                }
            }
            
            Section("testing grouping") {
                
            }
                
        }
        .task(id: ingredient) {
            print("ingredient updated")
            type = ingredient.type
        }
        .onChange(of: type) { _, newValue in
            if ingredient.type != newValue {
                ingredient.type = newValue
                StorageProvider.shared.update()
            }
        }
    }
}

#Preview {
    let ingredients = StorageProvider.shared.getAllIngredients()
    
    IngredientDetailView(ingredient: ingredients[0])
        .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext)
}
