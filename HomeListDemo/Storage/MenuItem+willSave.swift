//
//  MenuItem+willSave.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//

import Foundation
import CoreData

extension Character {
    var asString: String? {
        return String(self)
    }
}

extension MenuItem {
    override public func willSave() {
        super.willSave()
        setPrimitiveValue(name?.first?.asString, forKey: #keyPath(MenuItem.nameFirstLetter))
    }
}
