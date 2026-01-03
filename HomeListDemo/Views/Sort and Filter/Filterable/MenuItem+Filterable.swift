//
//  MenuItem+Filterable.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation
import CoreData

extension MenuItem: Filterable {
    static func priceTierString(_ int: Int?) -> String {
        if let int {
            return String(repeating: "$", count: int)
        } else {
            return "---"
        }
    }
    
    static func priceTierRawValue(_ int: Int?) -> String? {
        guard let int else { return nil }
        return String(int)
    }
    
    static let mealValues: [Meal] = Meal.allCases
    static let priceTierValues: [Int?] = [nil, 1, 2, 3, 4]
    
    static let selectableMealValues: [SelectableValue] = MenuItem.mealValues.map { SelectableValue(displayName: $0.displayName, rawValue: $0.rawValue) }
    
    static let selectablePriceTierValues: [SelectableValue] = MenuItem.priceTierValues.map { SelectableValue(displayName: priceTierString($0), rawValue: priceTierRawValue($0)) }
    
    static func filterName(for value: String?) -> NSPredicate? {
        NSPredicate.predicate(keyPathString: #keyPath(MenuItem.name), value: value)
    }

    static func filterIngredientList(for value: String?) -> NSPredicate? {
        NSPredicate.predicate(keyPathString: #keyPath(MenuItem.ingredientsList), value: value)
    }
    
    static func standardFilters() -> [FilterSelection] {
        return [
            FilterSelection(
                type: .picker,
                displayName: "Meal",
                keyPathString: #keyPath(MenuItem.meal),
                values: selectableMealValues
            ),
            FilterSelection(
                type: .picker,
                displayName: "Price",
                keyPathString: #keyPath(MenuItem.priceTier),
                values: selectablePriceTierValues
            ),
            FilterSelection(
                type: .textField,
                displayName: "Name",
                keyPathString: #keyPath(MenuItem.name),
                values: []
            ),
            FilterSelection(
                type: .textField,
                displayName: "Ingredients",
                keyPathString: #keyPath(MenuItem.ingredientsList),
                values: []
            )
        ]
    }
}
