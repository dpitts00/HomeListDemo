//
//  StorageProvider+update.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/10/26.
//

import Foundation
import CoreData

extension StorageProvider {
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
}
