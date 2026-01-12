//
//  RestaurantListItem.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//

import SwiftUI

struct RestaurantListItem: View {
    @Environment(\.editMode) var editMode

    var item: Restaurant
    var currentList: RestaurantList?
    var tapAction: () -> () = {}

    @State var isSelected: Bool = false

    var body: some View {
        Button {
            tapAction()
        } label: {
            HStack(spacing: 12) {
                if let _ = currentList {
                    Button {
                        isSelected.toggle()
                    } label: {
                        Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    }
                    .buttonStyle(.plain)
                }

                VStack(alignment: .leading) {
                    Text(item.name ?? "untitled")
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
        .deleteDisabled(!(editMode?.wrappedValue.isEditing ?? true))
        .task(id: item) {
            isSelected = currentList?.items?.contains(item) ?? false
        }
        .onChange(of: isSelected) { _, isSelected in
            guard let currentList else { return }
            if currentList.items?.contains(item) ?? false {
                currentList.removeFromItems(item)
                StorageProvider.shared.update()
            } else {
                currentList.addToItems(item)
                StorageProvider.shared.update()
            }
        }
    }
}

#Preview {
    RestaurantListItem(
        item: StorageProvider.shared.getAllRestaurants()[0],
        tapAction: { print("tap") }
    )
}
