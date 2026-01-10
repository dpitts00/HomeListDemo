//
//  HouseholdItemListItem.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//


import SwiftUI

struct HouseholdItemListItem: View {
    var item: HouseholdItem
    var currentList: HouseholdItemList?
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
                    Text(item.name ?? "")
                        .font(.headline)
                    Text(item.room ?? "-")
                        .font(.subheadline)
                }
                Spacer()
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
    HouseholdItemListItem(
        item: StorageProvider.shared.getAllHouseholdItems()[0],
        leadingAction: {},
        trailingAction: {},
        tapAction: {}
    )
}
