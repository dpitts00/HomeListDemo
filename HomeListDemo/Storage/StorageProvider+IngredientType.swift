//
//  StorageProvider+IngredientType.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/14/26.
//

import Foundation
import CoreData

extension StorageProvider {
    @discardableResult
    func saveIngredientType(named name: String) -> IngredientType? {
        let item = IngredientType(context: persistentContainer.viewContext)
        item.name = name
        
        do {
            try persistentContainer.viewContext.save()
            print("Success saving IngredientType")
            return item
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error saving IngredientType: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getAllIngredientTypes() -> [IngredientType] {
        getAll(IngredientType.self)
    }
    
    func deleteIngredientType(_ type: Ingredient) {
        delete(type)
    }
    
    func deleteAllIngredientTypes() {
        deleteAll(IngredientType.self)
    }
}

extension IngredientType {
    static let typesByName: NSFetchRequest<IngredientType> = {
        let request: NSFetchRequest<IngredientType> = IngredientType.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \IngredientType.name, ascending: true)
        ]
        return request
    }()
}
