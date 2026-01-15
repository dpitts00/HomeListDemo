//
//  IngredientQty+ingredientId.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/14/26.
//

import Foundation
import CoreData

extension IngredientQty {
    // this exists to deal with Optional key path not being acceptable to Swift Algorithms chunked(on:)
    // this is not ideal, but the ObjectIdentifier is also a class
    var ingredientId: String {
        ingredient?.name ?? ""
    }
}
