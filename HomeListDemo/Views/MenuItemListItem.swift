//
//  MenuItemListItem.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI

struct MenuItemListItem: View {
    var menuItem: MenuItem
    
    var body: some View {
        Button {
            
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(menuItem.nameString)
                        .font(.headline)
                    Text(menuItem.meal ?? "")
                        .font(.subheadline)
                }
                Spacer()
                Text(menuItem.priceTierString)
            }
        }
    }
}

#Preview {
    MenuItemListItem(menuItem: StorageProvider.shared.getAllMenuItems()[0]) // this will crash if empty
}
