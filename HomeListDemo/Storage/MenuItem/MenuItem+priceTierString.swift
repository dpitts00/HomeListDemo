//
//  MenuItem+priceTierString.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import Foundation
import CoreData

extension MenuItem {
    var nameString: String {
        name ?? ""
    }
    
    var priceTierString: String {
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
