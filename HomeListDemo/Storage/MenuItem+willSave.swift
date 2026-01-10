//
//  MenuItem+willSave.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//

import Foundation
import CoreData

extension MenuItem {
    override public func willSave() {
        super.willSave()
        setPrimitiveValue(name?.first?.asString?.uppercased(), forKey: #keyPath(MenuItem.nameFirstLetter))
    }
}
