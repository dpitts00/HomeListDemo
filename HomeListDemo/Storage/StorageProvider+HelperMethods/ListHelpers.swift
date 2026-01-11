//
//  ListHelpers.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/8/26.
//

import Foundation
import CoreData // ?

public struct ListHelpers {
    public static func sectionDisplayName(for id: (any Hashable)?) -> String {
        if let id = id as? String {
            if id.hasPrefix("Meal"),
                let meal = Meal(rawValue: id) {
                return meal.displayName
            }
            
            return id
        }
        
        return ""
    }
}

