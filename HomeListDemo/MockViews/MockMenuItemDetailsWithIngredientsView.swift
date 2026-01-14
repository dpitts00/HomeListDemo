//
//  MockMenuItemDetailsWithIngredientsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/27/25.
//

import SwiftUI

struct MockMenuItemDetailsWithIngredientsView: View {
    @Environment(\.editMode) var editMode
    
    @State var name: String = "zucchini pasta"
    @State var ingredientsList: String = "zucchini\nspaghetti\nchicken apple sausage\ngrated Parmesan"
    @State var meal: String = "dinner"
    @State var priceTier: String = "$$"
    
    @State var ingredientText: String = ""
    @State var ingredientsArray: [String] = ["Zucchini", "Spaghetti", "Chicken apple sausage", "Parmesan"]
    
    @State var possibleMatches: [String] = []
    
    var body: some View {
        List {
            Section("Name") {
                TextField("Name", text: $name)
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
                     
            Section("Ingredients") {
                // will also check "isEditing" here
                ForEach(ingredientsArray, id: \.self) { item in
                    HStack {
                        Text(item)
                        
                        Spacer()
                    }
                }
                .onDelete { indexSet in
                    ingredientsArray.remove(atOffsets: indexSet)
                }
                
                VStack {
                    HStack {
                        TextField("add an ingredient", text: $ingredientText)
                        
                        Button{
                            addIngredient(ingredientText)
                        } label: {
                            Image(systemName: "plus")
                        }
                        .tint(ingredientText.isEmpty ? .gray : .blue)
                    }
                    
                    ForEach(possibleMatches, id: \.self) { match in
                        Button {
                            addIngredient(match)
                        } label: {
                            Text(match)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(.plain)
                        .foregroundStyle(.blue)
                    }
                }
                
            }
            
            Button {
                if editMode?.wrappedValue.isEditing ?? true {
                    editMode?.wrappedValue = .inactive
                } else {
                    editMode?.wrappedValue = .active
                }
            } label: {
                Text((editMode?.wrappedValue.isEditing ?? true) ? "Done editing" : "Edit ingredients")
            }
            .buttonStyle(.plain)
            .foregroundStyle(.blue)
        }
        .onChange(of: ingredientText) { _, text in
            if text.isEmpty {
                possibleMatches = []
            } else {
                possibleMatches = ["butter", "butternut squash", "pork butt"]
            }
        }
    }
    
    // do not write functions like this
    func addIngredient(_ name: String) {
        if let _ = ingredientsArray.firstIndex(of: name) {
            // do nothing
        } else {
            ingredientsArray.append(name)
        }
        
        ingredientText = ""
    }
}

#Preview {
    MockMenuItemDetailsWithIngredientsView()
}
