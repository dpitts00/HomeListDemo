//
//  MenuItem+sortedArray.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/13/26.
//


import Foundation
import CoreData

extension MenuItem {
    var ingredientQtysArray: [IngredientQty] {
        ingredients?.sortedArray(using: [
            NSSortDescriptor(keyPath: \IngredientQty.ingredient?.name, ascending: true)
        ]) as? [IngredientQty] ?? []
    }
}

