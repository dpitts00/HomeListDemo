//
//  RestaurantDetailsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI
import CoreData

struct RestaurantDetailsView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var item: Restaurant
    
    @State var name: String = ""
    @State var menuItemList: String = ""
    @State var priceTier: SelectableValue?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Name", text: $name)
                }
                
                Section("Menu Items") {
                    TextEditor(text: $menuItemList)
                        .frame(minHeight: 300)
                }
                
                Section {
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
                menuItemList = item.menuItemList ?? ""
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

extension RestaurantDetailsView {
    func updateItem() {
        item.name = name
        item.menuItemList = menuItemList
        item.priceTier = Int16(Int(priceTier?.rawValue ?? "1") ?? 1)
        
        StorageProvider.shared.updateRestaurants()
    }
}

#Preview {
    @Previewable
    @State var item = StorageProvider.shared.getAllRestaurants()[0]
    
    RestaurantDetailsView(item: item)
        .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext)
}
