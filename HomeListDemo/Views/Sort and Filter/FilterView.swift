//
//  FilterView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/1/26.
//

import SwiftUI
import CoreData

struct FilterView<T: Filterable>: View {
    @Binding var predicate: NSPredicate?
    
    @State var filterSelections: [FilterSelection] = T.standardFilters()
        
    var body: some View {
        List {
            Section("Filter by") {
                ForEach($filterSelections, id: \.self) { $filter in
                    Picker(filter.displayName, selection: $filter.selectedValue) {
                        ForEach(filter.values, id: \.self) { value in
                            Text(value.displayName)
                                .tag(value.rawValue, includeOptional: true) // maybe not
                        }
                    }
                }
                .onChange(of: filterSelections) { _, newValue in
                    let predicates = newValue.compactMap { $0.predicate }
                    predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
                }
            }
            
            Button(role: .destructive) {
                filterSelections.enumerated().forEach { index, selection in
                    filterSelections[index].clearSelection()
                }
            } label: {
                Text("Clear all filters")
            }
        }
    }
}

#Preview {
    FilterView<MenuItem>(predicate: .constant(nil))
}
