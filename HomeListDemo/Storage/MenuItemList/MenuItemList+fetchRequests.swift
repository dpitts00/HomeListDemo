//
//  MenuItemList+fetchRequests.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/4/26.
//

import Foundation
import CoreData

extension MenuItemList {
    static let lists: NSFetchRequest<MenuItemList> = {
        let request: NSFetchRequest<MenuItemList> = MenuItemList.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \MenuItemList.name, ascending: true)
        ]
        return request
    }()
    
    static let currentList: NSFetchRequest<MenuItemList> = {
        let request: NSFetchRequest<MenuItemList> = MenuItemList.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate.predicate(keyPathString: #keyPath(MenuItemList.isCurrent), value: true)
        return request
    }()
}
