//
//  FilterView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/1/26.
//

import SwiftUI
import CoreData

struct FilterView<T: Filterable>: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var predicate: NSPredicate?
    
    @State var filterSelections: [FilterSelection] = T.standardFilters()
        
    var body: some View {
        List {
            Section("Filter by") {
                ForEach($filterSelections, id: \.self) { $filter in
                    FilterSelectionView(filter: $filter)
                }
            }
            .onChange(of: filterSelections) { _, newValue in
                let predicates = newValue.compactMap { $0.predicate }
                predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
                dismiss()
            }
            
            Button(role: .destructive) {
                filterSelections.enumerated().forEach { index, selection in
                    filterSelections[index].clearSelection()
                }
                dismiss()
            } label: {
                Text("Clear all filters")
            }
        }
    }
}

#Preview {
    FilterView<MenuItem>(predicate: .constant(nil))
}
