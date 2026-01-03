//
//  MenuItemDetailsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI
import CoreData

struct MenuItemDetailsView: View {
    @Environment(\.dismiss) var dismiss
    
    var item: MenuItem
    
    @State var name: String = ""
    @State var ingredientsList: String = ""
    @State var meal: SelectableValue?
    @State var priceTier: SelectableValue?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Name", text: $name)
                }
                
                Section("Ingredients") {
                    TextEditor(text: $ingredientsList)
                        .frame(minHeight: 300)
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
                ingredientsList = item.ingredientsList ?? ""
                meal = MenuItem.selectableMealValues.first(where: { $0.rawValue == item.meal })
                priceTier = MenuItem.selectablePriceTierValues.first(where: { $0.rawValue == String(item.priceTier) })
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
        item.ingredientsList = ingredientsList
        item.meal = meal?.rawValue
        item.priceTier = Int16(Int(priceTier?.rawValue ?? "1") ?? 1)
        
        StorageProvider.shared.updateMenuItems()
    }
}

#Preview {
    @Previewable
    @State var item = StorageProvider.shared.getAllMenuItems()[0]
    
    MenuItemDetailsView(item: item)
        .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext)
}
