//
//  MenuItem+Sortable.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation
import CoreData

extension MenuItem: Sortable {
    static func standardSorts() -> [any SortSelection] {
        return [
            StringSortSelection(displayName: "Name asc", keyPath: \MenuItem.nameFirstLetter, ascending: true),
            StringSortSelection(displayName: "Name desc", keyPath: \MenuItem.nameFirstLetter, ascending: false),
            StringSortSelection(displayName: "Meal asc", keyPath: \MenuItem.meal, ascending: true),
            StringSortSelection(displayName: "Meal desc", keyPath: \MenuItem.meal, ascending: false)
        ]
    }
}
