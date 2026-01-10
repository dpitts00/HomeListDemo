//
//  RestaurantListItem.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//

import SwiftUI

struct RestaurantListItem: View {
    var item: Restaurant
    var currentList: RestaurantList?
    var leadingAction: () -> ()
    var trailingAction: () -> ()
    var tapAction: () -> ()

    var body: some View {
        Button {
            tapAction()
        } label: {
            HStack(spacing: 12) {
                if let currentList {
                    Image(systemName: currentList.items?.contains(item) ?? false ? "checkmark.square.fill" : "square")
                }

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
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                leadingAction()
            } label: {
                Text("Select")
                Image(systemName: "plus")
            }
        }
    }
}

#Preview {
    RestaurantListItem(
        item: StorageProvider.shared.getAllRestaurants()[0],
        leadingAction: {},
        trailingAction: {},
        tapAction: {}
    )
}
