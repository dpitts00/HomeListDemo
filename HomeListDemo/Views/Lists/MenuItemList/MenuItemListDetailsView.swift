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
    let lists = StorageProvider.shared.getAllMenuItemLists()
    if lists.count > 0 {
        MenuItemListDetailsView(list: lists[0])
    } else {
        Text("no lists saved")
    }
}
