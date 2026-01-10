//
//  HouseholdItemsListView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI
import CoreData

struct HouseholdItemsListView: View {
    @SectionedFetchRequest(fetchRequest: HouseholdItem.householdItemsByRoom, sectionIdentifier: \HouseholdItem.room)
    var sectionedItems: SectionedFetchResults<String?, HouseholdItem>
    
    @State var searchText: String = ""
    @State var showFilter: Bool = false
    @State var showSort: Bool = false
    
    @State var selectedItem: HouseholdItem?

    var body: some View {
        NavigationStack {
            List {
                ForEach(sectionedItems) { section in
                    Section(section.id ?? "uncategorized") {
                        ForEach(section) { item in
                            HouseholdItemListItem(
                                item: item,
                                action: { selectedItem = item }
                            )
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let item = section[index]
                                StorageProvider.shared.deleteHouseholdItem(item)
                            }
                        }
                    }
                }
                
                Section {
                    if sectionedItems.isEmpty {
                        Button {
                            if !searchText.isEmpty {
                                StorageProvider.shared.saveHouseholdItem(named: searchText)
                            }
                        } label: {
                            Label("Add New Item", systemImage: "plus")
                        }
                    }
                }
                    
                Section {
                    if !sectionedItems.isEmpty {
                        Button(role: .destructive) {
                            StorageProvider.shared.deleteAllHouseholdItems()
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
                
                sectionedItems.nsPredicate = NSPredicate(
                    format: "%K CONTAINS[cd] %@",
                    argumentArray: [
                        #keyPath(HouseholdItem.name),
                        newValue
                    ]
                )
            }
            .navigationTitle("Household")
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
                
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .searchable(text: $searchText, placement: .automatic, prompt: Text("Household item?"))
            .sheet(isPresented: $showFilter) {
                FilterView<HouseholdItem>(predicate: $sectionedItems.nsPredicate)
                    .presentationDetents([.medium])
            }
            .sheet(isPresented: $showSort) {
                SortView<HouseholdItem, String>(
                    sortDescriptors: $sectionedItems.nsSortDescriptors,
                    sectionIdentifier: $sectionedItems.sectionIdentifier
                )
                    .presentationDetents([.medium])
            }
            .sheet(item: $selectedItem) { item in
                HouseholdItemDetailsView(item: item)
            }
        }
    }
}

#Preview {
    HouseholdItemsListView()
        .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext)
}
