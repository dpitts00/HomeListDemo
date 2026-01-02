//
//  MockMenuView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/27/25.
//

import SwiftUI

struct MockMenuView: View {
    var body: some View {
        TabView {
            Tab {
                MockHouseholdItemsListView()
            } label: {
                Text("Household")
                Image(systemName: "cross.case")
            }

            Tab {
                MockMenuItemsListView()
            } label: {
                Text("Menu")
                Image(systemName: "fork.knife")
            }

            Tab {
                MockFavoriteRestaurantsListView()
            } label: {
                Text("Restaurants")
                Image(systemName: "takeoutbag.and.cup.and.straw")
            }
        }
    }
}

#Preview {
    MockMenuView()
}
