//
//  RestaurantList+itemsArray.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/10/26.
//

import Foundation
import CoreData

extension RestaurantList {
    var itemsArray: [Restaurant] {
        items?.sortedArray(using: [
            NSSortDescriptor(keyPath: \Restaurant.name, ascending: true)
        ]) as? [Restaurant] ?? []
    }
}

