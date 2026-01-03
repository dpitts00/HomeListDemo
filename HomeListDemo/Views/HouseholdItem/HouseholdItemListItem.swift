//
//  HouseholdItemListItem.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//


import SwiftUI

struct HouseholdItemListItem: View {
    var item: HouseholdItem
    var action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
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
        .swipeActions {
            Button(role: .destructive) {
                StorageProvider.shared.deleteHouseholdItem(item)
            } label: {
                Text("Delete")
                Image(systemName: "trash.fill")
            }
        }

    }
}

#Preview {
    HouseholdItemListItem(
        item: StorageProvider.shared.getAllHouseholdItems()[0],
        action: {}
    )
}
