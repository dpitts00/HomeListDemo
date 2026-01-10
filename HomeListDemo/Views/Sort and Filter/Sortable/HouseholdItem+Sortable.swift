//
//  HouseholdItem+Sortable.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation
import CoreData

extension HouseholdItem: Sortable {
    static func standardSorts() -> [any SortSelection] {
        return [
            StringSortSelection(displayName: "Name asc", keyPath: \HouseholdItem.nameFirstLetter, ascending: true),
            StringSortSelection(displayName: "Name desc", keyPath: \HouseholdItem.nameFirstLetter, ascending: false),
            StringSortSelection(displayName: "Room asc", keyPath: \HouseholdItem.room, ascending: true),
            StringSortSelection(displayName: "Room desc", keyPath: \HouseholdItem.room, ascending: false)
        ]
    }
}
