//
//  StorageProvider+MenuItem.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import Foundation
import CoreData

extension StorageProvider {
    func saveMenuItem(named name: String, ingredients: String = "", meal: String? = nil, priceTier: Int = 0) {
        let menuItem = MenuItem(context: persistentContainer.viewContext)
        menuItem.name = name
        menuItem.ingredientsList = ingredients
        menuItem.meal = meal
        menuItem.priceTier = Int16(priceTier)
        
        do {
            try persistentContainer.viewContext.save()
            print("Success saving MenuItem")
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error saving MenuItem: \(error.localizedDescription)")
        }
    }
    
    func getAllMenuItems() -> [MenuItem] {
        let fetchRequest: NSFetchRequest<MenuItem> = MenuItem.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching [MenuItem]: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteMenuItem(_ menuItem: MenuItem) {
        persistentContainer.viewContext.delete(menuItem)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error deleting MenuItem: \(error.localizedDescription)")
        }
    }
    
    func updateMenuItems() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error updating MenuItem: \(error.localizedDescription)")
        }
    }
}

extension MenuItem {
    func update() {
        do {
            try managedObjectContext?.save()
        } catch {
            managedObjectContext?.rollback()
            print("Error updating MenuItem (directly): \(error.localizedDescription)")
        }
    }
}

extension StorageProvider {
    // DEBUG only
    func deleteAllMenuItems() {
        getAllMenuItems().forEach { menuItem in
            deleteMenuItem(menuItem)
        }
    }
}
