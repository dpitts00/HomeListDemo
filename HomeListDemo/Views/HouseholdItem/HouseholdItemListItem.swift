//
//  HouseholdItemListItem.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//


import SwiftUI

struct HouseholdItemListItem: View {
    @Environment(\.editMode) var editMode

    var item: HouseholdItem
    var currentList: HouseholdItemList?
    var tapAction: () -> () = {}
    
    @State var isSelected: Bool = false

    var body: some View {
        Button {
            tapAction()
        } label: {
            HStack(spacing: 12) {
                if let _ = currentList {
                    Button {
                        handleSelected(item: item)
                    } label: {
                        Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    }
                    .buttonStyle(.plain)
                }

                VStack(alignment: .leading) {
                    Text(item.name ?? "untitled")
                        .font(.headline)
                    Text(item.room ?? "-")
                        .font(.subheadline)
                }
                Spacer()
            }
        }
        .contentShape(Rectangle())
        .deleteDisabled(!(editMode?.wrappedValue.isEditing ?? true))
        .task(id: item) {
            isSelected = currentList?.items?.contains(item) ?? false
        }
    }
    
    func handleSelected(item: HouseholdItem) {
        guard let currentList else { return }
        if currentList.items?.contains(item) ?? false {
            currentList.removeFromItems(item)
            StorageProvider.shared.update()
            
            isSelected = false
        } else {
            currentList.addToItems(item)
            StorageProvider.shared.update()
            
            isSelected = true
        }
    }
}

#Preview {
    HouseholdItemListItem(
        item: StorageProvider.shared.getAllHouseholdItems()[0],
        tapAction: { print("tap") }
    )
}
