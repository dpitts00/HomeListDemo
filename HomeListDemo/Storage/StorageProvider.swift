//
//  StorageProvider.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/27/25.
//

import Foundation
import CoreData

class StorageProvider {
    static let shared = StorageProvider()
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        self.persistentContainer = NSPersistentContainer(name: "HomeListModel")
        
        self.persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("CoreData store failed to load with error: \(error.localizedDescription)")
            }
        }
        
        // DEBUG
        if getAllMenuItems().isEmpty {
            saveMenuItem(named: "waffles", meal: "breakfast", priceTier: 1)
            saveMenuItem(named: "egg sandwich", meal: "breakfast", priceTier: 1)
            saveMenuItem(named: "uncrustables", meal: "lunch", priceTier: 1)
            saveMenuItem(named: "pasta salad", meal: "lunch", priceTier: 2)
            saveMenuItem(named: "pita and hummus", meal: "lunch", priceTier: 1)
            saveMenuItem(named: "zucchini spaghetti", meal: "dinner", priceTier: 1)
            saveMenuItem(named: "dumplings and sushi", meal: "dinner", priceTier: 1)
            saveMenuItem(named: "frozen pizza and caesar salad", meal: "dinner", priceTier: 2)
        }
    }
}
