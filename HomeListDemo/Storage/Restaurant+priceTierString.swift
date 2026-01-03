//
//  Restaurant+priceTierString.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/3/26.
//

import Foundation
import CoreData

extension Restaurant {
    var nameString: String {
        name ?? ""
    }
    
    @objc
    var priceTierString: String? {
        switch priceTier {
        case 0:
            return ""
        case 1:
            return "$"
        case 2:
            return "$$"
        case 3:
            return "$$$"
        case 4:
            return "$$$$"
        default:
            return ""
        }
    }
}
