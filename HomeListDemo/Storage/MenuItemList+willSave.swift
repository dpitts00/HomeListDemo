//
//  MenuItemList+willSave.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/8/26.
//

import Foundation
import CoreData

extension MenuItemList {
    // this has the same effect as the derived property, doesn't work
    override public func willSave() {
        super.willSave()
        setPrimitiveValue(items?.count ?? 0, forKey: #keyPath(MenuItemList.itemCount))
    }
}
