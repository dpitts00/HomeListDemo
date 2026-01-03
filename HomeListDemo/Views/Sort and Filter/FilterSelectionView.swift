//
//  FilterSelectionView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/2/26.
//

import SwiftUI

struct FilterSelectionView: View {
    @Binding var filter: FilterSelection
    
    @State var typedValue: String = ""
    
    var body: some View {
        if filter.type == .picker {
            Picker(filter.displayName, selection: $filter.selectedValue) {
                ForEach(filter.values, id: \.self) { value in
                    Text(value.displayName)
                        .tag(value.rawValue, includeOptional: true) // maybe not
                }
            }
        } else {
            TextField(
                filter.displayName,
                text: $typedValue,
                prompt: Text(filter.displayName)
            )
            .onSubmit {
                filter.selectedValue = typedValue
            }
            .onAppear {
                typedValue = filter.selectedValue ?? "" // ??
            }
        }

    }
}

#Preview {
    @Previewable
    @State var filter = MenuItem.standardFilters()[0]
    
    FilterSelectionView(filter: $filter)
}
