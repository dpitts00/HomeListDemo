//
//  NSPredicate+predicate.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation
import CoreData

extension NSPredicate {
    public static func predicate(keyPathString: String, value: Any?) -> NSPredicate? {
        guard let value else { return nil }
        return NSPredicate(
            format: "%K CONTAINS[cd] %@",
            argumentArray: [
                keyPathString,
                value
            ]
        )
    }
}
