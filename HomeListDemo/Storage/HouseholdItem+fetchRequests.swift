//
//  HouseholdItem+fetchRequests.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation
import CoreData

extension HouseholdItem {
    static let householdItemsByRoom: NSFetchRequest<HouseholdItem> = {
        let request: NSFetchRequest<HouseholdItem> = HouseholdItem.fetchRequest()
        request.sortDescriptors = [
            sortByRoomAscending,
            sortByNameAscending
        ]
        return request
    }()
    
    static let sortByNameAscending = NSSortDescriptor(keyPath: \HouseholdItem.name, ascending: true)
    static let sortByNameDescending = NSSortDescriptor(keyPath: \HouseholdItem.name, ascending: false)
    static let sortByRoomAscending = NSSortDescriptor(keyPath: \HouseholdItem.room, ascending: true)
    static let sortByRoomDescending = NSSortDescriptor(keyPath: \HouseholdItem.room, ascending: false)
    
}

