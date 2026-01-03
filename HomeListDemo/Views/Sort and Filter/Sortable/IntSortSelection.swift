//
//  IntSortSelection.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//

import Foundation
import CoreData

struct IntSortSelection<T: Hashable>: SortSelection {
    let displayName: String
    let keyPath: KeyPath<T, Int16> // ?? Using Hashable instead of the NSManagedObject -- does this work?
    let ascending: Bool
    
    var id: String {
        displayName // for now
    }
    
    var sortDescriptor: NSSortDescriptor? {
        return NSSortDescriptor(keyPath: keyPath, ascending: ascending)
    }
    
    var sectionIdentifier: AnyKeyPath {
        keyPath
    }
}
