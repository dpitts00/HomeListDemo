//
//  StorageProvider+Ingredient.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/12/26.
//

import Foundation
import CoreData

extension StorageProvider {
    @discardableResult
    func saveIngredient(named name: String) -> Ingredient? {
        let item = Ingredient(context: persistentContainer.viewContext)
        item.name = name
        
        do {
            try persistentContainer.viewContext.save()
            print("Success saving Ingredient")
            return item
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error saving Ingredient: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getAllIngredients() -> [Ingredient] {
        getAll(Ingredient.self)
    }
    
    func deleteIngredient(_ ingredient: Ingredient) {
        delete(ingredient)
    }
    
    func deleteAllIngredients() {
        deleteAll(Ingredient.self)
    }
}

extension Ingredient {
    static let ingredientsByName: NSFetchRequest<Ingredient> = {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)
        ]
        return request
    }()
}
