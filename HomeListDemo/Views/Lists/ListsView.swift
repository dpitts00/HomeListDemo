//
//  ListsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/4/26.
//

import SwiftUI
import CoreData

struct ListsView: View {
    @FetchRequest(fetchRequest: MenuItemList.lists)
    var menuItemLists: FetchedResults<MenuItemList>
    
    @FetchRequest(fetchRequest: RestaurantList.lists)
    var restaurantLists: FetchedResults<RestaurantList>
    
    @FetchRequest(fetchRequest: HouseholdItemList.lists)
    var householdItemLists: FetchedResults<HouseholdItemList>
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("Menu") {
                    ForEach(menuItemLists) { list in
                        MenuItemListItemView(list: list, path: $path)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let item = menuItemLists[index]
                            StorageProvider.shared.deleteMenuItemList(item)
                        }
                    }
                    
                    Button(role: .destructive) {
                        menuItemLists.forEach { list in
                            StorageProvider.shared.deleteMenuItemList(list)
                        }
                    } label: {
                        Text("Delete all")
                    }
                }
                
                Section("Restaurant") {
                    ForEach(restaurantLists) { list in
                        HStack {
                            Text(list.name ?? "")
                            Spacer()
                            Text("\(list.items?.count ?? 0)")
                        }
                    }
                }

                Section("Household") {
                    ForEach(householdItemLists) { list in
                        HStack {
                            Text(list.name ?? "")
                            Spacer()
                            Text("\(list.items?.count ?? 0)")
                        }
                    }
                }
            }
            .navigationDestination(for: MenuItemList.self) { list in
                MenuItemListDetailsView(list: list)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .navigationTitle("Lists")
            .toolbarTitleDisplayMode(.inlineLarge)
        }
    }
}

#Preview {
    ListsView()
        .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext)
}
