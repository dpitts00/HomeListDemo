//
//  MenuItemListItem.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI
import CoreData

struct MenuItemListItem: View {
    @Environment(\.editMode) var editMode
    
    @ObservedObject var item: MenuItem
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
                        handleSelected(item: item)
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
    }
    
    func handleSelected(item: MenuItem) {
        guard let currentList else { return }
//        print("onChange", isSelected, item.name ?? "", currentList.items?.count ?? -1)
        if currentList.items?.contains(item) ?? false {
            currentList.removeFromItems(item)
            StorageProvider.shared.update()
//            print("removed \(item.name ?? "")")
            isSelected = false
        } else {
            currentList.addToItems(item)
            StorageProvider.shared.update()
//            print("added \(item.name ?? "")")
            isSelected = true
        }
        // TEST - no
//            StorageProvider.shared.persistentContainer.viewContext.refresh(currentList, mergeChanges: true)
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
