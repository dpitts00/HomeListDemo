//
//  MenuItemListItem.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI

struct MenuItemListItem: View {
    var menuItem: MenuItem
    var action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
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
        .swipeActions {
            Button(role: .destructive) {
                StorageProvider.shared.deleteMenuItem(menuItem)
            } label: {
                Text("Delete")
                Image(systemName: "trash.fill")
            }
        }

    }
}

#Preview {
    MenuItemListItem(
        menuItem: StorageProvider.shared.getAllMenuItems()[0],
        action: {}
    )
}
