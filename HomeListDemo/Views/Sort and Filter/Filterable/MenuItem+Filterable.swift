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
    
    static func standardFilters() -> [FilterSelection] {
        let mealValues: [String?] = [nil, "breakfast", "lunch", "dinner", "snacks"]
        let priceTierValues: [Int?] = [nil, 1, 2, 3, 4]
        
        return [
            FilterSelection(
                displayName: "Meal",
                keyPathString: #keyPath(MenuItem.meal),
                values: mealValues.map { SelectableValue(displayName: $0?.capitalized ?? "---", rawValue: $0) }
            ),
            FilterSelection(
                displayName: "Price",
                keyPathString: #keyPath(MenuItem.priceTier),
                values: priceTierValues.map { SelectableValue(displayName: priceTierString($0), rawValue: priceTierRawValue($0)) }
            )
            // need additional for name and ingredientsList string filtering (like the search text on list screen)
            // probably need to add "picker" or "textfield" type to the FilterSelection object
        ]
    }
}
