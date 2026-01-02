//
//  Filterable.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation

protocol Filterable {
    static func standardFilters() -> [FilterSelection]
}
