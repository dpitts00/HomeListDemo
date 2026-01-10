//
//  RestaurantList+fetchRequests.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/4/26.
//

import Foundation
import CoreData

extension RestaurantList {
    static let lists: NSFetchRequest<RestaurantList> = {
        let request: NSFetchRequest<RestaurantList> = RestaurantList.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \RestaurantList.name, ascending: true)
        ]
        return request
    }()
    
    static let currentList: NSFetchRequest<RestaurantList> = {
        let request: NSFetchRequest<RestaurantList> = RestaurantList.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate.predicate(keyPathString: #keyPath(RestaurantList.isCurrent), value: true)
        return request
    }()

}
