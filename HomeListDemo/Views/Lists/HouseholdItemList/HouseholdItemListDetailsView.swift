//
//  HouseholdItemListDetailsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/10/26.
//

import SwiftUI
import CoreData

struct HouseholdItemListDetailsView: View {
    @ObservedObject var list: HouseholdItemList
    
    @State private var name: String = ""
    
    var body: some View {
        List {
            Section("Name") {
                TextField("Name", text: $name)
            }

            Section("Household Items") {
                ForEach(list.itemsArray) { item in
                    Text(item.name ?? "")
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
    let lists = StorageProvider.shared.getAllHouseholdItemLists()
    if lists.count > 0 {
        HouseholdItemListDetailsView(list: lists[0])
    } else {
        Text("no lists saved")
    }
}
