//
//  Restaurant+Sortable.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//

import Foundation
import CoreData

extension Restaurant: Sortable {
    static func standardSorts() -> [any SortSelection] {
        return [
            StringSortSelection(displayName: "Name asc", keyPath: \Restaurant.nameFirstLetter, ascending: true),
            StringSortSelection(displayName: "Name desc", keyPath: \Restaurant.nameFirstLetter, ascending: false),
            StringSortSelection(displayName: "Price asc", keyPath: \Restaurant.priceTierString, ascending: true),
            StringSortSelection(displayName: "Price desc", keyPath: \Restaurant.priceTierString, ascending: false)
        ]
    }
}
