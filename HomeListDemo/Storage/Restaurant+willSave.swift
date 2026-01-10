//
//  Restaurant+willSave.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//

import Foundation
import CoreData

extension Restaurant {
    override public func willSave() {
        super.willSave()
        
        setPrimitiveValue(priceTierStringValue(), forKey: #keyPath(Restaurant.priceTierString))
        setPrimitiveValue(name?.first?.asString?.uppercased(), forKey: #keyPath(Restaurant.nameFirstLetter))
    }
}
