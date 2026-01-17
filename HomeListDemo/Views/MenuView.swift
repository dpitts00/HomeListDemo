//
//  MenuView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI
import CoreData

struct MenuView: View {
    var body: some View {
        TabView {
            Tab {
                HouseholdItemsListView()
            } label: {
                Text("Household")
                Image(systemName: "house")
            }

            Tab {
                MenuItemsListView()
            } label: {
                Text("Menu")
                Image(systemName: "fork.knife")
            }

            Tab {
                RestaurantsListView()
            } label: {
                Text("Restaurants")
                Image(systemName: "takeoutbag.and.cup.and.straw")
            }
            
            Tab {
                ListsView()
            } label: {
                Text("Lists")
                Image(systemName: "list.clipboard")
            }
            
            Tab {
                SettingsView()
            } label: {
                Text("Settings")
                Image(systemName: "gearshape")
            }

        }
        .task {
            IngredientTypeStrings.setupIngredientTypes(in: StorageProvider.shared)
        }
    }
}

#Preview {
    MenuView()
        .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext)
}
