//
//  MenuItemListItem.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI

struct MenuItemListItem: View {
    var item: MenuItem
    var currentList: MenuItemList?
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
                    Text(item.mealSelection.displayName)
                        .font(.subheadline)
                }
                Spacer()
                Text(item.priceTierString)
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
    List {
        MenuItemListItem(
            item: StorageProvider.shared.getAllMenuItems()[0],
            leadingAction: {},
            trailingAction: {},
            tapAction: {}
        )
    }
}
