//
//  SortView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/1/26.
//

import SwiftUI
import CoreData

struct SortView<T: Sortable, U: Hashable>: View {
    @Binding var sortDescriptors: [NSSortDescriptor] // SortDescriptor is typed by KeyPath<Root, Value>
    @Binding var sectionIdentifier: KeyPath<T, U?> // KeyPath<Root, Value?> is required
//    @Binding var sectionIdentifierKeyPath: AnyKeyPath?
    
    @State var sortSelections: [any SortSelection] = T.standardSorts()
    
    var body: some View {
        List {
            Section("Sort by") {
                ForEach(sortSelections, id: \.id) { selection in
                    Button {
                        sortDescriptors = [selection.sortDescriptor].compactMap { $0 }
                        if let identifier = selection.sectionIdentifier as? KeyPath<T, U?> {
                            sectionIdentifier = identifier
                        }
//                        sectionIdentifierKeyPath = selection.sectionIdentifier
                    } label: {
                        Text(selection.displayName)
                    }
                }
            }
        }
    }
}

#Preview {
    SortView<MenuItem, String>(
        sortDescriptors: .constant([MenuItem.sortByMealAscending]),
        sectionIdentifier: .constant(\MenuItem.meal)
//        sectionIdentifierKeyPath: .constant(nil)
    )
}
