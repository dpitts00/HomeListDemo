//
//  MenuItemList+itemsArray.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/8/26.
//

import Foundation
import CoreData

extension MenuItemList {
    var itemsArray: [MenuItem] {
        items?.sortedArray(using: [
            NSSortDescriptor(keyPath: \MenuItem.name, ascending: true)
        ]) as? [MenuItem] ?? []
    }
}
