//
//  MenuItemListItem.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI

struct MenuItemListItem: View {
    @Environment(\.editMode) var editMode
    
    var item: MenuItem
    var currentList: MenuItemList?
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
                    Text(item.mealSelection.displayName)
                        .font(.subheadline)
                }
                Spacer()
                Text(item.priceTierString)
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
    List {
        MenuItemListItem(
            item: StorageProvider.shared.getAllMenuItems()[0],
            tapAction: { print("tap") }
        )
    }
}
