//
//  StorageProvider+genericMethods.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/12/26.
//

import Foundation
import CoreData

extension StorageProvider {
    // don't - this obscures all the do/catch bit
    @discardableResult
    func save<T: NSManagedObject>() -> T? {
        let item = T(context: persistentContainer.viewContext)
        update()
        return item
    }
    
    func getAll<T: NSManagedObject>(_ type: T.Type) -> [T] {
        guard let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as? NSFetchRequest<T> else { return [] }
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching [\(T.self)]: \(error.localizedDescription)")
            return []
        }
    }
    
    func delete<T: NSManagedObject>(_ item: T) {
        persistentContainer.viewContext.delete(item)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error deleting \(T.self): \(error.localizedDescription)")
        }
    }
    
    func update() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                persistentContainer.viewContext.rollback()
                print("Error updating viewContext \(persistentContainer.viewContext.description): \(error.localizedDescription)")
            }
        }
    }
    
    // debug only
    func deleteAll<T: NSManagedObject>(_ type: T.Type) {
        getAll(T.self).forEach {
            delete($0)
        }
    }
}
