//
//  StorageProvider.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/27/25.
//

import Foundation
import CoreData

public class StorageProvider {
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
            saveMenuItem(named: "waffles", meal: .breakfast, priceTier: 1)
            saveMenuItem(named: "egg sandwich", meal: .breakfast, priceTier: 1)
            saveMenuItem(named: "uncrustables", meal: .lunch, priceTier: 1)
            saveMenuItem(named: "pasta salad", meal: .lunch, priceTier: 2)
            saveMenuItem(named: "pita and hummus", meal: .lunch, priceTier: 1)
            saveMenuItem(named: "zucchini spaghetti", meal: .dinner, priceTier: 1)
            saveMenuItem(named: "dumplings and sushi", meal: .dinner, priceTier: 1)
            saveMenuItem(named: "frozen pizza and caesar salad", meal: .dinner, priceTier: 2)
            saveMenuItem(named: "pretzels", meal: .snacks, priceTier: 1)
        }
        
        if getAllHouseholdItems().isEmpty {
            saveHouseholdItem(named: "soap", room: "bathroom")
            saveHouseholdItem(named: "shampoo", room: "bathroom")
            saveHouseholdItem(named: "conditioner", room: "bathroom")
            saveHouseholdItem(named: "face lotion", room: "bathroom")
            saveHouseholdItem(named: "laundry detergent", room: "laundry")
        }
        
        if getAllRestaurants().isEmpty {
            saveRestaurant(named: "Swad", menuItems: "paneer makhani\nbengan bharta\naan", priceTier: 2)
            saveRestaurant(named: "Culvers", menuItems: "cheeseburger", priceTier: 1)
            saveRestaurant(named: "Chipotle", menuItems: "burrito", priceTier: 1)
            saveRestaurant(named: "Mint Mark", menuItems: "", priceTier: 4)
            saveRestaurant(named: "Ha long bay", menuItems: "", priceTier: 2)
        }
        
        if getAllMenuItemLists().isEmpty {
            saveMenuItemList(named: "Menu List", isCurrent: true)
        }
        
        if getAllHouseholdItemLists().isEmpty {
            saveHouseholdItemList(named: "Household List", isCurrent: true)
        }
        
        if getAllRestaurantLists().isEmpty {
            saveRestaurantList(named: "Restaurant List", isCurrent: true)
        }
        
        if getAllIngredientTypes().isEmpty {
            saveIngredientType(named: "Dairy")
            saveIngredientType(named: "Produce")
            saveIngredientType(named: "Bakery")
            saveIngredientType(named: "Meat")
            saveIngredientType(named: "Pantry")
        }
        
//        IngredientTypeStrings.setupIngredientTypes(in: self)
    }
}
