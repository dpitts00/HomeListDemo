//
//  MenuItemListDetailsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/8/26.
//

import SwiftUI
import CoreData

struct MenuItemListDetailsView: View {
    var list: MenuItemList
    
    var body: some View {
        List {
            Section {
                Text(list.name ?? "")
            }
            
            Section("Menu Items") {
                ForEach(list.itemsArray) { item in
                    Text(item.nameString)
                }
            }
        }
    }
}

#Preview {
    MenuItemListDetailsView(list: StorageProvider.shared.getAllMenuItemLists()[0])
}
