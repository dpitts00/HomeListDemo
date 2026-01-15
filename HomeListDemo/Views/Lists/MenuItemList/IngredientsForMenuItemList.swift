//
//  IngredientsForMenuItemList.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/14/26.
//

import SwiftUI

struct IngredientsForMenuItemList: View {
    var list: MenuItemList
    
    @State var ingredientsForList: [IngredientWithQuantity] = []
        
    // add checkmarks -- .isSelected
    // is there any way to persist this list? it just gets regenerated every time right now

    // add sorting by type (after the sorting/grouping done already)
    // get all the types and do sections by it ??
    
    // need navigation INTO this view, no navigationDestination currently exists
    
    
    var body: some View {
        List{
            ForEach(StorageProvider.shared.getAllIngredientTypes()) { type in
                Section(type.name ?? "") {
                    ForEach(ingredients(for: type)) { item in
                        Text(item.name)
                    }
                }
            }
            
            Section("All ingredients") {
                ForEach(ingredientsForList) { item in
                    HStack(spacing: 12) {
                        Image(systemName: item.isSelected ? "checkmark.square.fill" : "square")
                            .onTapGesture {
                                if let index = ingredientsForList.firstIndex(of: item) {
                                    ingredientsForList[index].select()
                                }
                            }

                        VStack(alignment: .leading) {
                            LabeledContent {
                                Text("\(item.quantity)")
                            } label: {
                                Text(item.name)
                            }
                            
                            Text(item.menuItemsList)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .task {
            ingredientsForList = list.allIngredientQtysForMenuItemList()
            // need a merging function for persistence and such
        }
    }
    
    func ingredients(for type: IngredientType) -> [IngredientWithQuantity] {
        ingredientsForList.filter { $0.ingredient.type == type }
    }
}

#Preview {
    IngredientsForMenuItemList(list: StorageProvider.shared.getAllMenuItemLists()[0])
}
