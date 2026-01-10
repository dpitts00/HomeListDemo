//
//  MenuItemListItem.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI

struct MenuItemListItem: View {
    var menuItem: MenuItem
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
                    Image(systemName: currentList.items?.contains(menuItem) ?? false ? "checkmark.square.fill" : "square")
                }
                VStack(alignment: .leading) {
                    Text(menuItem.nameString)
                        .font(.headline)
                    Text(menuItem.mealSelection.displayName)
                        .font(.subheadline)
                }
                Spacer()
                Text(menuItem.priceTierString)
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
//        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
//            Button(role: .destructive) {
//                trailingAction()
//            } label: {
//                Text("Delete")
//                Image(systemName: "trash.fill")
//            }
//        }

    }
}

#Preview {
    List {
        MenuItemListItem(
            menuItem: StorageProvider.shared.getAllMenuItems()[0],
            leadingAction: {},
            trailingAction: {},
            tapAction: {}
        )
    }
}
