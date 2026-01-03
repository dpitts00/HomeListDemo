//
//  MenuItem+Meal.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation
import CoreData

enum Meal: String, CaseIterable {
    case none = "a"
    case breakfast = "b"
    case lunch = "c"
    case dinner = "d"
    case snacks = "e"
}

extension Meal {
    var displayName: String {
        switch self {
        case .none:
            return "uncategorized"
            
        case .breakfast:
            return "breakfast"
            
        case .lunch:
            return "lunch"
            
        case .dinner:
            return "dinner"
            
        case .snacks:
            return "snacks"
        }
    }
}

extension MenuItem {
    var mealSelection: Meal {
        if let meal {
            return Meal(rawValue: meal) ?? .none
        } else {
            return Meal.none
        }
    }
}
