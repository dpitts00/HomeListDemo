//
//  Restaurant+Filterable.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//

import Foundation
import CoreData

extension Restaurant: Filterable {
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
    
    static let priceTierValues: [Int?] = [nil, 1, 2, 3, 4]
    
    static let selectablePriceTierValues: [SelectableValue] = Restaurant.priceTierValues.map { SelectableValue(displayName: priceTierString($0), rawValue: priceTierRawValue($0)) }

    static func filterName(for value: String?) -> NSPredicate? {
        NSPredicate.predicate(keyPathString: #keyPath(Restaurant.name), value: value)
    }

    static func filterMenuItemsList(for value: String?) -> NSPredicate? {
        NSPredicate.predicate(keyPathString: #keyPath(Restaurant.menuItemList), value: value)
    }

    static func standardFilters() -> [FilterSelection] {
        return [
            FilterSelection(
                type: .picker,
                displayName: "Price",
                keyPathString: #keyPath(Restaurant.priceTier),
                values: selectablePriceTierValues
            ),
            FilterSelection(
                type: .textField,
                displayName: "Name",
                keyPathString: #keyPath(Restaurant.name),
                values: []
            )
        ]
    }
}
