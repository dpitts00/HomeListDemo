//
//  SortSelection.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import Foundation
import CoreData

protocol SortSelection: Identifiable, Hashable, Equatable {
    var id: String { get }
    var displayName: String { get }
    var sortDescriptor: NSSortDescriptor? { get }
    var sectionIdentifier: AnyKeyPath { get } // may need to typecast later for this
}

