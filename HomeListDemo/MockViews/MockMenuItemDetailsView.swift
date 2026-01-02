//
//  MockMenuItemDetailsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/27/25.
//

import SwiftUI

struct MockMenuItemDetailsView: View {
    @State var name: String = "zucchini pasta"
    @State var ingredientsList: String = "zucchini\nspaghetti\nchicken apple sausage\ngrated Parmesan"
    @State var meal: String = "dinner"
    @State var priceTier: String = "$$"
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $name)
            }
                     
            Section("Ingredients") {
                TextEditor(text: $ingredientsList)
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
    MockMenuItemDetailsView()
}
