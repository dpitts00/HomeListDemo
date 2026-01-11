//
//  HouseholdItemList+itemsArray.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/10/26.
//

import Foundation
import CoreData

extension HouseholdItemList {
    var itemsArray: [HouseholdItem] {
        items?.sortedArray(using: [
            NSSortDescriptor(keyPath: \HouseholdItem.name, ascending: true)
        ]) as? [HouseholdItem] ?? []
    }
}
