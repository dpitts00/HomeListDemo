//
//  StorageProvider+MenuItemList.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/4/26.
//

import Foundation
import CoreData

extension StorageProvider {
    func saveMenuItemList(named name: String, isCurrent: Bool = false) {
        let list = MenuItemList(context: persistentContainer.viewContext)
        list.name = name
        list.isCurrent = isCurrent
        
        do {
            try persistentContainer.viewContext.save()
            print("Success saving MenuItemList")
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error saving MenuItemList: \(error.localizedDescription)")
        }
    }
    
    func getAllMenuItemLists() -> [MenuItemList] {
        let fetchRequest: NSFetchRequest<MenuItemList> = MenuItemList.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching [MenuItemList]: \(error.localizedDescription)")
            return []
        }
    }
    
    func getCurrentMenuItemList() -> MenuItemList? {
        let fetchRequest: NSFetchRequest<MenuItemList> = MenuItemList.fetchRequest()
        fetchRequest.predicate = NSPredicate.predicate(keyPathString: #keyPath(MenuItemList.isCurrent), value: true)
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest).first
        } catch {
            print("Error fetching current MenuItemList: \(error.localizedDescription)")
            return nil
        }
    }
    
    func deleteMenuItemList(_ list: MenuItemList) {
        persistentContainer.viewContext.delete(list)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error deleting MenuItemList: \(error.localizedDescription)")
        }
    }
    
    func update() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error updating viewContext \(persistentContainer.viewContext.description): \(error.localizedDescription)")
        }
    }
}
