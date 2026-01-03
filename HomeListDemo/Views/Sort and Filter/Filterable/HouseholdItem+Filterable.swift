//
//  HouseholdItem+Filterable.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation
import CoreData

extension HouseholdItem: Filterable {
    static let roomValues: [String?] = [nil, "bedroom", "bathroom", "kitchen", "laundry"]
    static let userValues: [String?] = [nil, "K", "D", "J", "L"] // need multi-selection here

    static let selectableRoomValues: [SelectableValue] = HouseholdItem.roomValues.map { SelectableValue(displayName: $0 ?? "---", rawValue: $0) }
    
    static let selectableUserValues: [SelectableValue] = HouseholdItem.userValues.map { SelectableValue(displayName: $0 ?? "---", rawValue: $0) }
    
    static func filterName(for value: String?) -> NSPredicate? {
        NSPredicate.predicate(keyPathString: #keyPath(HouseholdItem.name), value: value)
    }

    static func filterRoom(for value: String?) -> NSPredicate? {
        NSPredicate.predicate(keyPathString: #keyPath(HouseholdItem.room), value: value)
    }
    
    static func standardFilters() -> [FilterSelection] {
        return [
            FilterSelection(
                type: .picker,
                displayName: "Room",
                keyPathString: #keyPath(HouseholdItem.room),
                values: selectableRoomValues
            ),
            FilterSelection(
                type: .picker,
                displayName: "User",
                keyPathString: #keyPath(HouseholdItem.user),
                values: selectableUserValues
            ),
            FilterSelection(
                type: .textField,
                displayName: "Name",
                keyPathString: #keyPath(HouseholdItem.name),
                values: []
            )
        ]
    }
}
