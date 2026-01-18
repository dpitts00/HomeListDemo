//
//  IngredientType+strings.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/17/26.
//

import Foundation
import CoreData

// matching strings for ingredient type

public struct IngredientTypeStrings {
    public static let produce = """
        lettuce
        tomato
        avocado
        potato
        onion
        pepper
        orange
        lemon
        apple
        pear
        grape
        berry
        berries
        eggplant
        leek
        cucumber
        """
    
    public static let meat = """
        chicken
        beef
        ham
        tofu
        """
    
    public static let dairy = """
        eggs
        milk
        yogurt
        cream
        cheese
        butter
        """
    
    public static let bakery = """
        bread
        bun
        tortilla
        roll
        """
    
    public static let pantry = """
        peanut butter
        jam
        tahini
        soy sauce
        vinegar
        salt
        pepper
        pasta
        noodle
        rice
        bean
        rotini
        spaghetti
        lasagna
        """
    
    public static var produceArray: [String] {
        produce.components(separatedBy: .newlines)
    }
    
    public static var meatArray: [String] {
        meat.components(separatedBy: .newlines)
    }
    
    public static var dairyArray: [String] {
        dairy.components(separatedBy: .newlines)
    }
    
    public static var bakeryArray: [String] {
        bakery.components(separatedBy: .newlines)
    }
    
    public static var pantryArray: [String] {
        pantry.components(separatedBy: .newlines)
    }
    
    public static func setupIngredientTypes(in storageProvider: StorageProvider) {
        let allIngredientTypes = storageProvider.getAllIngredientTypes()
        let allIngredients = storageProvider.getAllIngredients()
        
        allIngredients
            .filter { $0.type == nil }
            .forEach { $0.type = IngredientType.type(for: $0, in: allIngredientTypes) }
        
        storageProvider.update()
    }
}

extension IngredientType {
    public static func type(for ingredient: Ingredient, in types: [IngredientType]) -> IngredientType? {
        if ingredient.name?
            .components(separatedBy: .whitespaces)
            .contains(where: { nameComponent in
                if let _ = IngredientTypeStrings.produceArray.firstIndex(where: { string in
                    nameComponent.localizedLowercase.contains(string.localizedLowercase)
                }) {
                    return true
                } else {
                    return false
                }
            }) ?? false {
            return types.first(where: { $0.name?.localizedCaseInsensitiveContains("produce") ?? false })
        }
        
        if ingredient.name?
            .components(separatedBy: .whitespaces)
            .contains(where: { nameComponent in
                if let _ = IngredientTypeStrings.meatArray.firstIndex(where: { string in
                    nameComponent.localizedLowercase.contains(string.localizedLowercase)
                }) {
                    return true
                } else {
                    return false
                }
            }) ?? false {
            return types.first(where: { $0.name?.localizedCaseInsensitiveContains("meat") ?? false })
        }

        if ingredient.name?
            .components(separatedBy: .whitespaces)
            .contains(where: { nameComponent in
                if let _ = IngredientTypeStrings.dairyArray.firstIndex(where: { string in
                    nameComponent.localizedLowercase.contains(string.localizedLowercase)
                }) {
                    return true
                } else {
                    return false
                }
            }) ?? false {
            return types.first(where: { $0.name?.localizedCaseInsensitiveContains("dairy") ?? false })
        }
        
        if ingredient.name?
            .components(separatedBy: .whitespaces)
            .contains(where: { nameComponent in
                if let _ = IngredientTypeStrings.bakeryArray.firstIndex(where: { string in
                    nameComponent.localizedLowercase.contains(string.localizedLowercase)
                }) {
                    return true
                } else {
                    return false
                }
            }) ?? false {
            return types.first(where: { $0.name?.localizedCaseInsensitiveContains("bakery") ?? false })
        }
        
        if ingredient.name?
            .components(separatedBy: .whitespaces)
            .contains(where: { nameComponent in
                if let _ = IngredientTypeStrings.pantryArray.firstIndex(where: { string in
                    nameComponent.localizedLowercase.contains(string.localizedLowercase)
                }) {
                    return true
                } else {
                    return false
                }
            }) ?? false {
            return types.first(where: { $0.name?.localizedCaseInsensitiveContains("pantry") ?? false })
        }

        return nil
    }
}
