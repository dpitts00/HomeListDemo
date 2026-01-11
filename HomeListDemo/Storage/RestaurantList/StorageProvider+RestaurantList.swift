//
//  StorageProvider+RestaurantList.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/10/26.
//

import Foundation
import CoreData

extension StorageProvider {
    func saveRestaurantList(named name: String, isCurrent: Bool = false) {
        let list = RestaurantList(context: persistentContainer.viewContext)
        list.name = name
        list.isCurrent = isCurrent
        
        do {
            try persistentContainer.viewContext.save()
            print("Success saving RestaurantList")
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error saving RestaurantList: \(error.localizedDescription)")
        }
    }
    
    func getAllRestaurantLists() -> [RestaurantList] {
        let fetchRequest: NSFetchRequest<RestaurantList> = RestaurantList.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching [RestaurantList]: \(error.localizedDescription)")
            return []
        }
    }
    
    func getCurrentRestaurantList() -> RestaurantList? {
        let fetchRequest: NSFetchRequest<RestaurantList> = RestaurantList.fetchRequest()
        fetchRequest.predicate = NSPredicate.predicate(keyPathString: #keyPath(RestaurantList.isCurrent), value: true)
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest).first
        } catch {
            print("Error fetching current RestaurantList: \(error.localizedDescription)")
            return nil
        }
    }
    
    func deleteRestaurantList(_ list: RestaurantList) {
        persistentContainer.viewContext.delete(list)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error deleting RestaurantList: \(error.localizedDescription)")
        }
    }    
}
