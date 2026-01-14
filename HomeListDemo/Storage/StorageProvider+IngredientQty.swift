//
//  StorageProvider+IngredientQty.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/12/26.
//

import Foundation
import CoreData

extension StorageProvider {
    @discardableResult
    func saveIngredientQty(for ingredient: Ingredient) -> IngredientQty? {
        let item = IngredientQty(context: persistentContainer.viewContext)
        item.ingredient = ingredient
        item.quantity = 1
        
        do {
            try persistentContainer.viewContext.save()
            print("Success saving IngredientQty")
            return item
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error saving IngredientQty: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getAllIngredientQtys() -> [IngredientQty] {
        getAll(IngredientQty.self)
    }
    
    func deleteIngredientQty(_ ingredientQty: IngredientQty) {
        delete(ingredientQty)
    }
    
    func deleteAllIngredientQtys() {
        deleteAll(IngredientQty.self)
    }
}

extension IngredientQty {
    static let byName: NSFetchRequest<IngredientQty> = {
        let request: NSFetchRequest<IngredientQty> = IngredientQty.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \IngredientQty.ingredient?.name, ascending: true)
        ]
        return request
    }()
}
