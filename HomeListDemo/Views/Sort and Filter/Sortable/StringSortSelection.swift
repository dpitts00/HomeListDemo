//
//  StringSortSelection.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation
import CoreData

struct StringSortSelection: SortSelection {
    let displayName: String
    let keyPath: KeyPath<MenuItem, String?>
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
