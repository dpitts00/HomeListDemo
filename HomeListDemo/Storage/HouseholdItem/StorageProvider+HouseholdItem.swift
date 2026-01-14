//
//  StorageProvider+HouseholdItem.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation
import CoreData

extension StorageProvider {
    @discardableResult
    func saveHouseholdItem(named name: String, room: String? = nil, user: String? = nil) -> HouseholdItem? {
        let item = HouseholdItem(context: persistentContainer.viewContext)
        item.name = name
        item.room = room
        item.user = user
        
        do {
            try persistentContainer.viewContext.save()
            print("Success saving HouseholdItem")
            return item
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error saving HouseholdItem: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getAllHouseholdItems() -> [HouseholdItem] {
        let fetchRequest: NSFetchRequest<HouseholdItem> = HouseholdItem.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching [HouseholdItem]: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteHouseholdItem(_ item: HouseholdItem) {
        persistentContainer.viewContext.delete(item)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error deleting HouseholdItem: \(error.localizedDescription)")
        }
    }
    
    func updateHouseholdItems() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error updating HouseholdItem: \(error.localizedDescription)")
        }
    }
}

extension HouseholdItem {
    func update() {
        do {
            try managedObjectContext?.save()
        } catch {
            managedObjectContext?.rollback()
            print("Error updating HouseholdItem (directly): \(error.localizedDescription)")
        }
    }
}

extension StorageProvider {
    // DEBUG only
    func deleteAllHouseholdItems() {
        getAllHouseholdItems().forEach { item in
            deleteHouseholdItem(item)
        }
    }
}
