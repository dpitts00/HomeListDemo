//
//  RestaurantsListView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI
import CoreData

struct RestaurantsListView: View {
    @SectionedFetchRequest(fetchRequest: Restaurant.byPrice, sectionIdentifier: \Restaurant.priceTierString)
    var sectionedItems: SectionedFetchResults<String?, Restaurant>
    
    @State var searchText: String = ""
    @State var showFilter: Bool = false
    @State var showSort: Bool = false
    
    @State var selectedItem: Restaurant?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sectionedItems) { section in
                    Section(section.id ?? "") {
                        ForEach(section) { item in
                            RestaurantListItem(item: item) {
                                selectedItem = item
                            }
                        }
                    }
                }
                
                Section {
                    if sectionedItems.isEmpty {
                        Button {
                            if !searchText.isEmpty {
                                StorageProvider.shared.saveRestaurant(named: searchText)
                            }
                        } label: {
                            Label("Add New Item", systemImage: "plus")
                        }
                    }
                }
                    
                Section {
                    if !sectionedItems.isEmpty {
                        Button(role: .destructive) {
                            StorageProvider.shared.deleteAllRestaurants()
                        } label: {
                            Label("Delete All", systemImage: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                }

            }
            .onChange(of: searchText) { _, newValue in
                guard !newValue.isEmpty else {
                    sectionedItems.nsPredicate = nil
                    return
                }
                
                // this should be a compound predicate OR with menuItemsList property
                sectionedItems.nsPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [
                    Restaurant.filterName(for: newValue),
                    Restaurant.filterMenuItemsList(for: newValue)
                ].compactMap { $0 })
            }
            .navigationTitle("Restaurants")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSort.toggle()
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFilter.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
            }
            .searchable(text: $searchText, placement: .automatic, prompt: Text("Restaurant or menu item?"))
            .sheet(isPresented: $showFilter) {
                FilterView<Restaurant>(predicate: $sectionedItems.nsPredicate)
                    .presentationDetents([.medium])
            }
            .sheet(isPresented: $showSort) {
                SortView<Restaurant, String>(
                    sortDescriptors: $sectionedItems.nsSortDescriptors,
                    sectionIdentifier: $sectionedItems.sectionIdentifier
                    
                )
                    .presentationDetents([.medium])
            }
            .sheet(item: $selectedItem) { item in
                RestaurantDetailsView(item: item)
            }
        }
    }
}

#Preview {
    RestaurantsListView()
        .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext)
}
