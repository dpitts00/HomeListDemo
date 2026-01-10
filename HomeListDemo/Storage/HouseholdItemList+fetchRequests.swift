//
//  HouseholdItemList+fetchRequests.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/4/26.
//

import Foundation
import CoreData

extension HouseholdItemList {
    static let lists: NSFetchRequest<HouseholdItemList> = {
        let request: NSFetchRequest<HouseholdItemList> = HouseholdItemList.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \HouseholdItemList.name, ascending: true)
        ]
        return request
    }()
    
    static let currentList: NSFetchRequest<HouseholdItemList> = {
        let request: NSFetchRequest<HouseholdItemList> = HouseholdItemList.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate.predicate(keyPathString: #keyPath(HouseholdItemList.isCurrent), value: true)
        return request
    }()
}
