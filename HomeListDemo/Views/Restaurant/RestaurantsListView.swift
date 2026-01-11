//
//  RestaurantsListView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI
import CoreData

struct RestaurantsListView: View {
    @FetchRequest(fetchRequest: RestaurantList.currentList)
    private var currentListArray: FetchedResults<RestaurantList>
    
    @SectionedFetchRequest(fetchRequest: Restaurant.byPrice, sectionIdentifier: \Restaurant.priceTierString)
    var sectionedItems: SectionedFetchResults<String?, Restaurant>
    
    @State var searchText: String = ""
    @State var showFilter: Bool = false
    @State var showSort: Bool = false
    
    @State var selectedItem: Restaurant?
    
    @State var selectedList: RestaurantList?
    @State var onlyShowSelectedItems: Bool = false
    
    var currentList: RestaurantList? {
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
                    Section(section.id ?? "") {
                        ForEach(section) { item in
                            RestaurantListItem(
                                item: item,
                                currentList: currentList,
                                leadingAction: {
                                   selectedItem = item
                                },
                                trailingAction: {},
                                tapAction: {
                                    guard let currentList else { return }
                                    if currentList.items?.contains(item) ?? false {
                                        currentList.removeFromItems(item)
                                        StorageProvider.shared.update()
                                    } else {
                                        currentList.addToItems(item)
                                        StorageProvider.shared.update()
                                    }
                                }
                            )
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let item = section[index]
                                StorageProvider.shared.deleteRestaurant(item)
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
            .onChange(of: currentList) { _, list in
                if list == nil {
                    onlyShowSelectedItems = false
                }
            }
            .navigationTitle("Restaurants")
            .toolbarTitleDisplayMode(.large) // .large or .inlineLarge
            .toolbar {
                if let _ = currentList {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            onlyShowSelectedItems.toggle()
                        } label: {
                            Image(systemName: onlyShowSelectedItems ? "eye.fill" : "eye")
                        }
                    }
                }

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
            .onChange(of: onlyShowSelectedItems) { _, show in
                searchText = ""
                
                if show,
                    let currentList {
                    sectionedItems.nsPredicate = NSPredicate.predicate(keyPathString: #keyPath(Restaurant.lists), value: currentList)
                } else {
                    sectionedItems.nsPredicate = nil
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
