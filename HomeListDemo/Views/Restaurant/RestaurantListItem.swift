//
//  RestaurantListItem.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//

import SwiftUI

struct RestaurantListItem: View {
    var item: Restaurant
    var action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.nameString)
                        .font(.headline)
                    Text((item.menuItemList?.isEmpty ?? false) ? "-" : item.menuItemList ?? "-")
                        .font(.subheadline)
                        .lineLimit(3)
                }
                Spacer()
                Text(item.priceTierString ?? "")
            }
        }
        .contentShape(Rectangle())
        .swipeActions {
            Button(role: .destructive) {
                StorageProvider.shared.deleteRestaurant(item)
            } label: {
                Text("Delete")
                Image(systemName: "trash.fill")
            }
        }

    }
}

#Preview {
    RestaurantListItem(
        item: StorageProvider.shared.getAllRestaurants()[0],
        action: {}
    )
}
