//
//  Sortable.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation

protocol Sortable {
    static func standardSorts() -> [any SortSelection]
}
