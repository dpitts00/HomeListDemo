//
//  StorageProvider+Ingredient.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/12/26.
//

import Foundation
import CoreData
import Algorithms

extension StorageProvider {
    @discardableResult
    func saveIngredient(named name: String) -> Ingredient? {
        let item = Ingredient(context: persistentContainer.viewContext)
        item.name = name
        
        let allIngredientTypes = getAllIngredientTypes()
        item.type = IngredientType.type(for: item, in: allIngredientTypes)
        
        do {
            try persistentContainer.viewContext.save()
            print("Success saving Ingredient")
            return item
        } catch {
            persistentContainer.viewContext.rollback()
            print("Error saving Ingredient: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getAllIngredients() -> [Ingredient] {
        getAll(Ingredient.self)
    }
    
    func deleteIngredient(_ ingredient: Ingredient) {
        delete(ingredient)
    }
    
    func deleteAllIngredients() {
        deleteAll(Ingredient.self)
    }
}

extension Ingredient {
    static let ingredientsByName: NSFetchRequest<Ingredient> = {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)
        ]
        return request
    }()
}

extension MenuItem {
    func allIngredientsForMenuItem() -> [Ingredient] {
        ((ingredients as? Set<IngredientQty>) ?? Set())
            .compactMap { $0.ingredient }
    }
    
    func allIngredientQtysForMenuItem() -> [IngredientQty] {
        Array((ingredients as? Set<IngredientQty>) ?? Set())
    }
}

extension MenuItemList {
    func allIngredientsForMenuItemList() -> [Ingredient] {
        ((items as? Set<MenuItem>) ?? Set())
            .flatMap { $0.allIngredientsForMenuItem() }
    }
    
    func allIngredientQtysForMenuItemList() -> [IngredientWithQuantity] {
        let chunks = ((items as? Set<MenuItem>) ?? Set())
            .flatMap { $0.allIngredientQtysForMenuItem() }
            .sorted(by: { $0.ingredientId < $1.ingredientId })
            .chunked(on: \.ingredient)
        
        return chunks.compactMap { ingredient, chunk in
            guard let ingredient else { return nil }
            
            let quantity = chunk
                .map { $0.quantity }
                .reduce(0, +)
            
            let menuItems = chunk
                .compactMap { $0.menuItem }
                .sorted(by: { $0.nameString < $1.nameString })
            
            return IngredientWithQuantity(
                ingredient: ingredient,
                quantity: Int(quantity),
                menuItems: menuItems
            )
        }
    }
}

extension Ingredient {
    static func ingredientsForMenuItem(_ menuItem: MenuItem) -> NSFetchRequest<Ingredient> {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Ingredient.type, ascending: true),
            NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)
        ]
        request.predicate = NSPredicate.predicate(keyPathString: #keyPath(Ingredient.quantities.menuItem), value: menuItem)
        return request
    }
    
    static func menuItemsForIngredient(_ ingredient: Ingredient) -> NSFetchRequest<MenuItem> {
        let request: NSFetchRequest<MenuItem> = MenuItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \MenuItem.name, ascending: true)]
        // cannot have two relationships (in diff models) named the same thing
        request.predicate = NSPredicate.predicate(keyPathString: #keyPath(MenuItem.ingredients.ingredient), value: ingredient)
        return request
    }
    
    // crash log says this is "unimplemented SQL generation", but it seems to understand the intent at least?
    static func ingredientsForMenuItemList(_ menuItemList: MenuItemList) -> NSFetchRequest<Ingredient> {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Ingredient.type, ascending: true),
            NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)
        ]
        request.predicate = NSPredicate.predicateIn(keyPathString: #keyPath(Ingredient.quantities.menuItem.lists), value: menuItemList) // to-many not allowed
        return request
    }
}

extension StorageProvider {
    func getMenuItemsForIngredient(_ ingredient: Ingredient) -> [MenuItem] {
        get(fetchRequest: Ingredient.menuItemsForIngredient(ingredient))
    }
    
    func getIngredientsForMenuItem(_ menuItem: MenuItem) -> [Ingredient] {
        get(fetchRequest: Ingredient.ingredientsForMenuItem(menuItem))
    }
}
