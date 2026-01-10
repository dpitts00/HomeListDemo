//
//  RestaurantListDetailsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/10/26.
//

import SwiftUI
import CoreData

struct RestaurantListDetailsView: View {
    var list: RestaurantList
    
    @State private var name: String = ""
    
    var body: some View {
        List {
            Section("Name") {
                TextField("Name", text: $name)
            }

            Section("Restaurants") {
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
    let lists = StorageProvider.shared.getAllRestaurantLists()
    if lists.count > 0 {
        RestaurantListDetailsView(list: lists[0])
    } else {
        Text("no lists saved")
    }
}
