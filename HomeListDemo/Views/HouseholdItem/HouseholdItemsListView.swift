//
//  HouseholdItemsListView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI
import CoreData

struct HouseholdItemsListView: View {
    @FetchRequest(fetchRequest: HouseholdItemList.currentList)
    private var currentListArray: FetchedResults<HouseholdItemList>
    
    @SectionedFetchRequest(fetchRequest: HouseholdItem.householdItemsByRoom, sectionIdentifier: \HouseholdItem.room)
    var sectionedItems: SectionedFetchResults<String?, HouseholdItem>
    
    @State var searchText: String = ""
    @State var showFilter: Bool = false
    @State var showSort: Bool = false
    
    @State var selectedItem: HouseholdItem?
    
    @State var selectedList: HouseholdItemList?
    @State var onlyShowSelectedItems: Bool = false

    var currentList: HouseholdItemList? {
        currentListArray.first
    }

    var body: some View {
        NavigationStack {
            List {
                if let currentList {
                    Button {
                        selectedList = currentList
                    } label: {
                        LabeledContent {
                            Text("\(currentList.itemCount)")
                        } label: {
                            Label((currentList.name ?? "").isEmpty ? "Untitled" : (currentList.name ?? ""), systemImage: "star.fill")
                                .foregroundStyle(.primary)
                        }
                    }
                }

                ForEach(sectionedItems) { section in
                    Section(section.id ?? "uncategorized") {
                        ForEach(section) { item in
                            HouseholdItemListItem(
                                item: item,
                                currentList: currentList,
                                tapAction: {
                                    selectedItem = item
                                }
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
            .onChange(of: currentList) { _, list in
                if list == nil {
                    onlyShowSelectedItems = false
                }
            }
            .onChange(of: onlyShowSelectedItems) { _, show in
                searchText = ""
                
                if show,
                    let currentList {
                    sectionedItems.nsPredicate = NSPredicate.predicate(keyPathString: #keyPath(HouseholdItem.lists), value: currentList)
                } else {
                    sectionedItems.nsPredicate = nil
                }
            }
            .navigationTitle("Household")
            .toolbarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                if let _ = currentList {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            onlyShowSelectedItems.toggle()
                        } label: {
                            Label(onlyShowSelectedItems ? "Show all items" : "Show only selected items", systemImage: onlyShowSelectedItems ? "eye.fill" : "eye")
                        }
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSort.toggle()
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFilter.toggle()
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let newItem = StorageProvider.shared.saveHouseholdItem(named: "")
                        selectedItem = newItem
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
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
