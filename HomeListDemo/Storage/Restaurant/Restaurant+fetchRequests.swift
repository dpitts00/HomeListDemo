//
//  Restaurant+fetchRequests.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//

import Foundation
import CoreData

extension Restaurant {
    static let byName: NSFetchRequest<Restaurant> = {
        let request: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Restaurant.name, ascending: true)
        ]
        return request
    }()
    
    static let byPrice: NSFetchRequest<Restaurant> = {
        let request: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        request.sortDescriptors = [
            sortByPriceAscending,
            sortByNameAscending
        ]
        return request
    }()
    
    static let sortByNameAscending = NSSortDescriptor(keyPath: \Restaurant.name, ascending: true)
    static let sortByNameDescending = NSSortDescriptor(keyPath: \Restaurant.name, ascending: false)
    static let sortByPriceAscending = NSSortDescriptor(keyPath: \Restaurant.priceTier, ascending: true)
    static let sortByPriceDescending = NSSortDescriptor(keyPath: \Restaurant.priceTier, ascending: false)
}

