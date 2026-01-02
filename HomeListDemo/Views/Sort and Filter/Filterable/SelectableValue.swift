//
//  SelectableValue.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation

struct SelectableValue: Hashable, Equatable {
    let displayName: String
    let rawValue: String? // how do we get Int?
}
