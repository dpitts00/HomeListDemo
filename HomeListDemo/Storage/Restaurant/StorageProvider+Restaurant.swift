//
//  StorageProvider+Restaurant.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//
import Foundation
import CoreData

extension StorageProvider {
    func saveRestaurant(named name: String, menuItems: String = "", priceTier: Int = 0) {
        let item = Restaurant(context: persistentContainer.viewContext)
        item.name = name
        item.menuItemList = menuItems
        item.priceTier = Int16(priceTier)
        
        do {
            try persistentContainer.viewContext.save()
            print("Success saving Restaurant")
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error saving Restaurant: \(error.localizedDescription)")
        }
    }
    
    func getAllRestaurants() -> [Restaurant] {
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching [Restaurant]: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteRestaurant(_ item: Restaurant) {
        persistentContainer.viewContext.delete(item)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error deleting Restaurant: \(error.localizedDescription)")
        }
    }
    
    // TODO: Error - not updating the view when the priceTier is updated, even though the model is updated
    func updateRestaurants() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error updating Restaurant: \(error.localizedDescription)")
        }
    }
}

extension Restaurant {
    func update() {
        do {
            try managedObjectContext?.save()
        } catch {
            managedObjectContext?.rollback()
            print("Error updating Restaurant (directly): \(error.localizedDescription)")
        }
    }
}

extension StorageProvider {
    // DEBUG only
    func deleteAllRestaurants() {
        getAllRestaurants().forEach { item in
            deleteRestaurant(item)
        }
    }
}
