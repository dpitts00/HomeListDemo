//
//  HouseholdItem+willSave.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/8/26.
//

import Foundation
import CoreData

extension HouseholdItem {
    override public func willSave() {
        super.willSave()
        setPrimitiveValue(name?.first?.asString?.uppercased(), forKey: #keyPath(HouseholdItem.nameFirstLetter))
    }
}
