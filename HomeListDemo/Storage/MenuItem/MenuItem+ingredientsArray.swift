//
//  MenuItem+ingredientsArray.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/11/26.
//

import Foundation
import CoreData

extension MenuItem {
    var ingredientsArray: [Ingredient] {
        ingredients?.sortedArray(using: [
            NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)
        ]) as? [Ingredient] ?? []
    }
}
