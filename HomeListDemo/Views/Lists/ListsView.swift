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
    
    @State private var showMenu = false
    @State private var forceRefresh: String = ""
    
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
                        RestaurantListItemView(list: list, path: $path)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let item = restaurantLists[index]
                            StorageProvider.shared.deleteRestaurantList(item)
                        }
                    }
                    
                    Button(role: .destructive) {
                        restaurantLists.forEach { list in
                            StorageProvider.shared.deleteRestaurantList(list)
                        }
                    } label: {
                        Text("Delete all")
                    }
                }

                Section("Household") {
                    ForEach(householdItemLists) { list in
                        HouseholdItemListView(list: list, path: $path)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let item = householdItemLists[index]
                            StorageProvider.shared.deleteHouseholdItemList(item)
                        }
                    }
                    
                    Button(role: .destructive) {
                        householdItemLists.forEach { list in
                            StorageProvider.shared.deleteHouseholdItemList(list)
                        }
                    } label: {
                        Text("Delete all")
                    }
                }
            }
            .navigationDestination(for: MenuItemList.self) { list in
                MenuItemListDetailsView(list: list)
            }
            .navigationDestination(for: RestaurantList.self) { list in
                RestaurantListDetailsView(list: list)
            }
            .navigationDestination(for: HouseholdItemList.self) { list in
                HouseholdItemListDetailsView(list: list)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showMenu = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .contextMenu(menuItems: {
                        Button {
                            StorageProvider.shared.saveMenuItemList(named: "")
                        } label: {
                            Text("New Menu List")
                        }
                        
                        Button {
                            StorageProvider.shared.saveRestaurantList(named: "")
                        } label: {
                            Text("New Restaurant List")
                        }

                        Button {
                            StorageProvider.shared.saveHouseholdItemList(named: "")
                        } label: {
                            Text("New Household List")
                        }
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .navigationTitle("Lists")
            .toolbarTitleDisplayMode(.large) // .large or .inlineLarge
        }
    }
}

#Preview {
    ListsView()
        .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext)
}
