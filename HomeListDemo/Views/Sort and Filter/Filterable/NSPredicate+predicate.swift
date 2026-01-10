//
//  NSPredicate+predicate.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation
import CoreData

extension NSPredicate {
    public static func predicate(keyPathString: String, value: String?) -> NSPredicate? {
        guard let value else { return nil }
        return NSPredicate(
            format: "%K CONTAINS[cd] %@",
            argumentArray: [
                keyPathString,
                value
            ]
        )
    }
    
    public static func predicate(keyPathString: String, value: Int32?) -> NSPredicate? {
        guard let value else { return nil }
        return NSPredicate(
            format: "%K == %@",
            argumentArray: [
                keyPathString,
                value
            ]
        )
    }
    
    public static func predicate(keyPathString: String, value: Int16?) -> NSPredicate? {
        guard let value else { return nil }
        return NSPredicate(
            format: "%K == %@",
            argumentArray: [
                keyPathString,
                value
            ]
        )
    }

    public static func predicate(keyPathString: String, value: Bool) -> NSPredicate? {
        return NSPredicate(
            format: "%K == %@",
            argumentArray: [
                keyPathString,
                value
            ]
        )
    }
    
    // for checking MenuItem.lists for a specific MenuItemList
    public static func predicate(keyPathString: String, value: MenuItemList?) -> NSPredicate {
        return NSPredicate(
            format: "%K CONTAINS %@",
            argumentArray: [
                keyPathString,
                value
            ]
        )
    }
}
