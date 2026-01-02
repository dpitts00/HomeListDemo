//
//  MockFavoriteRestaurantDetailsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/27/25.
//

import SwiftUI

struct MockFavoriteRestaurantDetailsView: View {
    @State var name: String = "Hot 'n Spicy"
    @State var menuItems: String = "pho\npad thai\npad see ew"
    @State var meal: String = "dinner"
    @State var priceTier: String = "$$"
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $name)
            }
                     
            Section("Menu Items") {
                TextEditor(text: $menuItems)
                    .frame(minHeight: 300)
            }
            
            Section {
                Picker("Meal", selection: $meal) {
                    ForEach(["breakfast", "lunch", "dinner", "snacks"], id: \.self) { meal in
                        Text(meal)
                    }
                }
                
                Picker("Price", selection: $priceTier) {
                    ForEach(["$", "$$", "$$$", "$$$$"], id: \.self) { price in
                        Text(price)
                    }
                }
            }
        }
    }
}

#Preview {
    MockFavoriteRestaurantDetailsView()
}
