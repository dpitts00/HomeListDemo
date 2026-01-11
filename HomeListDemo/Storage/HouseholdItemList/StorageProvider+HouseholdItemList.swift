//
//  StorageProvider+HouseholdItemList.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/10/26.
//

import Foundation
import CoreData

extension StorageProvider {
    func saveHouseholdItemList(named name: String, isCurrent: Bool = false) {
        let list = HouseholdItemList(context: persistentContainer.viewContext)
        list.name = name
        list.isCurrent = isCurrent
        
        do {
            try persistentContainer.viewContext.save()
            print("Success saving HouseholdItemList")
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error saving HouseholdItemList: \(error.localizedDescription)")
        }
    }
    
    func getAllHouseholdItemLists() -> [HouseholdItemList] {
        let fetchRequest: NSFetchRequest<HouseholdItemList> = HouseholdItemList.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching [HouseholdItemList]: \(error.localizedDescription)")
            return []
        }
    }
    
    func getCurrentHouseholdItemList() -> HouseholdItemList? {
        let fetchRequest: NSFetchRequest<HouseholdItemList> = HouseholdItemList.fetchRequest()
        fetchRequest.predicate = NSPredicate.predicate(keyPathString: #keyPath(HouseholdItemList.isCurrent), value: true)
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest).first
        } catch {
            print("Error fetching current HouseholdItemList: \(error.localizedDescription)")
            return nil
        }
    }
    
    func deleteHouseholdItemList(_ list: HouseholdItemList) {
        persistentContainer.viewContext.delete(list)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error deleting HouseholdItemList: \(error.localizedDescription)")
        }
    }    
}
