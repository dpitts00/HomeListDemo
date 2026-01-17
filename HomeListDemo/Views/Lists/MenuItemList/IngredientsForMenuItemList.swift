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
                        GroceryListItemView(
                            item: item,
                            list: list,
                            selectIngredient: selectIngredient
                        )
                    }
                }
            }
            
            Section("Other") {
                ForEach(ingredients(for: nil)) { item in
                    GroceryListItemView(
                        item: item,
                        list: list,
                        selectIngredient: selectIngredient
                    )
                }
            }
        }
        .onAppear {
            ingredientsForList = list.allIngredientQtysForMenuItemList()
            
            guard let selectedIngredients = list.selectedIngredients as? Set<Ingredient> else { return }
            ingredientsForList.enumerated().forEach { index, item in
                if selectedIngredients.contains(item.ingredient) {
                    ingredientsForList[index].isSelected = true
                }
            }
        }
    }
    
    func ingredients(for type: IngredientType?) -> [IngredientWithQuantity] {
        ingredientsForList.filter { $0.ingredient.type == type }
    }
    
    func selectIngredient(_ ingredient: Ingredient, in list: MenuItemList) {
        guard let selectedIngredients = list.selectedIngredients as? Set<Ingredient> else { return }
        if selectedIngredients.contains(ingredient) {
            list.removeFromSelectedIngredients(ingredient)
        } else {
            list.addToSelectedIngredients(ingredient)
        }
        
        if let index = ingredientsForList.firstIndex(where: { $0.ingredient == ingredient }) {
            ingredientsForList[index].select()
        }
    }
}

#Preview {
    IngredientsForMenuItemList(list: StorageProvider.shared.getAllMenuItemLists()[0])
}
