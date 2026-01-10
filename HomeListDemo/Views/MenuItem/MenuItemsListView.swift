//
//  MenuItemsListView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI
import CoreData

struct MenuItemsListView: View {
    @FetchRequest(fetchRequest: MenuItemList.currentList)
    private var currentListArray: FetchedResults<MenuItemList>
    
    @SectionedFetchRequest(fetchRequest: MenuItem.menuItemsByMeal, sectionIdentifier: \MenuItem.meal)
    var sectionedItems: SectionedFetchResults<String?, MenuItem>
    
    @State var searchText: String = ""
    @State var showFilter: Bool = false
    @State var showSort: Bool = false
    
    @State var selectedItem: MenuItem?
    
    @State var selectedList: MenuItemList?
    @State var onlyShowSelectedItems: Bool = false
    
    var currentList: MenuItemList? {
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
                            Label(currentList.name ?? "", systemImage: "star.fill")
                                .foregroundStyle(.primary)
                        }
                    }
                }
                
                ForEach(sectionedItems) { section in
                    Section(ListHelpers.sectionDisplayName(for: section.id)) {
                        ForEach(section) { item in
                            MenuItemListItem(
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
                                StorageProvider.shared.deleteMenuItem(item)
                            }
                        }
                    }
                }
                
                Section {
                    if sectionedItems.isEmpty {
                        Button {
                            if !searchText.isEmpty {
                                StorageProvider.shared.saveMenuItem(named: searchText)
                            }
                        } label: {
                            Label("Add New Item", systemImage: "plus")
                        }
                    }
                }
                    
                Section {
                    if !sectionedItems.isEmpty {
                        Button(role: .destructive) {
                            StorageProvider.shared.deleteAllMenuItems()
                        } label: {
                            Label("Delete All", systemImage: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                }

            }
            .onChange(of: currentList?.items) { _, newValue in
                // DEBUG ONLY, it's not updating the fetched results in the Lists tab
                print("currentList.items changed")
            }
            .onChange(of: searchText) {
                _,
                newValue in
                guard !newValue.isEmpty else {
                    sectionedItems.nsPredicate = nil
                    return
                }
                
                sectionedItems.nsPredicate = NSCompoundPredicate(
                    orPredicateWithSubpredicates: [
                        MenuItem.filterName(for: newValue),
                        MenuItem.filterIngredientList(for: newValue)
                    ].compactMap { $0 }
                )
            }
            .navigationTitle("Menu")
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
                    sectionedItems.nsPredicate = NSPredicate.predicate(keyPathString: #keyPath(MenuItem.lists), value: currentList)
                } else {
                    sectionedItems.nsPredicate = nil
                }
            }
            .searchable(text: $searchText, placement: .automatic, prompt: Text("Menu item?"))
            .sheet(isPresented: $showFilter) {
                FilterView<MenuItem>(predicate: $sectionedItems.nsPredicate)
                    .presentationDetents([.medium])
            }
            .sheet(isPresented: $showSort) {
                SortView<MenuItem, String>(
                    sortDescriptors: $sectionedItems.nsSortDescriptors,
                    sectionIdentifier: $sectionedItems.sectionIdentifier
                )
                    .presentationDetents([.medium])
            }
            .sheet(item: $selectedItem) { item in
                MenuItemDetailsView(item: item)
            }
            .sheet(item: $selectedList) { list in
                MenuItemListDetailsView(list: list)
            }
        }
    }
}

#Preview {
    MenuItemsListView()
        .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext)
}
