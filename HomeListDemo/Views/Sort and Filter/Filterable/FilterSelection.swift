//
//  FilterSelection.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation
import CoreData

// can declare an array of these on the object using them
struct FilterSelection: Hashable, Equatable {
    let type: FieldType
    let displayName: String
    let keyPathString: String
    let values: [SelectableValue]
    var selectedValue: String?
    var predicate: NSPredicate? {
        guard let selectedValue else { return nil }
        return NSPredicate.predicate(keyPathString: keyPathString, value: selectedValue)
    }
    
    mutating func clearSelection() {
        selectedValue = nil
    }
}
