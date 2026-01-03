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
            StringSortSelection(displayName: "Name asc", keyPath: \Restaurant.name, ascending: true),
            StringSortSelection(displayName: "Name desc", keyPath: \Restaurant.name, ascending: false),
            IntSortSelection(displayName: "Price asc", keyPath: \Restaurant.priceTier, ascending: true),
            IntSortSelection(displayName: "Price desc", keyPath: \Restaurant.priceTier, ascending: false)
        ]
    }
}
