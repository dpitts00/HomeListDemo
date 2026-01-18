//
//  MenuItemListDetailsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/8/26.
//

import SwiftUI
import CoreData

struct IngredientWithQuantity: Identifiable, Hashable {
    var id: ObjectIdentifier {
        ingredient.id
    }
    
    // but NOT the CoreData model
    let ingredient: Ingredient
    let quantity: Int
    let menuItems: [MenuItem]
    var isSelected: Bool = false
    
    var name: String {
        ingredient.name ?? ""
    }
    
    // replace with a localized list formatter
    var menuItemsList: String {
        menuItems
            .compactMap { $0.name }
            .joined(separator: ", ")
    }
    
    mutating func select() {
        isSelected.toggle()
    }
}

struct MenuItemListDetailsView: View {
    @Binding var path: NavigationPath
    
    var list: MenuItemList
    var hideGroceryList: Bool = false
    
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
            
            Button {
                path.append(ListPath.groceryList(list: list))
            } label: {
                Text("Grocery List")
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
    @Previewable
    @State var path = NavigationPath()
    
    let lists = StorageProvider.shared.getAllMenuItemLists()

    NavigationStack(path: $path) {
        MenuItemListDetailsView(path: $path, list: lists[0])
            .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext) // NO
            .navigationDestination(for: MenuItemList.self) { list in
                IngredientsForMenuItemList(list: list)
            }
    }
}
