//
//  MenuItem+fetchRequests.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import Foundation
import CoreData

/* The formats of FetchRequest that can be used in a SwiftUI View
 
 @FetchRequest(
     sortDescriptors: [
         NSSortDescriptor(keyPath: \MenuItem.name, ascending: false)
     ],
     predicate: nil
 ) var basicMenuItems: FetchedResults<MenuItem>
 
 @FetchRequest(fetchRequest: MenuItem.menuItemsByName)
 var menuItems: FetchedResults<MenuItem>
 
 @SectionedFetchRequest(fetchRequest: MenuItem.menuItemsByName, sectionIdentifier: \MenuItem.name)
 var sectionedMenuItems: SectionedFetchResults<String?, MenuItem>

 */

/* And display sections like this -- the dict uses "id"
 
 //                ForEach(sectionedMenuItems) { section in
 //                    Section("\(section.id ?? "untitled section")") {
 //                        ForEach(section) { menuItem in
 //                            Button {
 //
 //                            } label: {
 //                                HStack {
 //                                    Text(menuItem.name ?? "untitled")
 //                                    Spacer()
 //                                    Text("\(menuItem.priceTier)")
 //                                }
 //                            }
 //                        }
 //                    }
 //                }

 */

extension MenuItem {
    static let menuItemsByName: NSFetchRequest<MenuItem> = {
        let request: NSFetchRequest<MenuItem> = MenuItem.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \MenuItem.name, ascending: false)
        ]
        return request
    }()
    
    static let menuItemsByMeal: NSFetchRequest<MenuItem> = {
        let request: NSFetchRequest<MenuItem> = MenuItem.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \MenuItem.meal, ascending: false)
        ]
        return request
    }()
    
    static let sortByNameAscending = NSSortDescriptor(keyPath: \MenuItem.name, ascending: true)
    static let sortByNameDescending = NSSortDescriptor(keyPath: \MenuItem.name, ascending: false)
    static let sortByMealAscending = NSSortDescriptor(keyPath: \MenuItem.meal, ascending: true)
    static let sortByMealDescending = NSSortDescriptor(keyPath: \MenuItem.meal, ascending: false)
    
    static func filterByMeal(_ meal: String?) -> NSPredicate? {
        guard let meal else { return nil }
        return NSPredicate(
            format: "%K CONTAINS[cd] %@",
            argumentArray: [
                #keyPath(MenuItem.name),
                meal
            ]
        )
    }
    
    // doesn't work -- what's the KeyPath type?
    static func filter(_ keyPath: KeyPath<MenuItem, String?>, keyword: String?) -> NSPredicate? {
        guard let keyword else { return nil }
        return NSPredicate(
            format: "%K CONTAINS[cd] %@",
            argumentArray: [
                keyPath,
                keyword
            ]
        )
    }
}

