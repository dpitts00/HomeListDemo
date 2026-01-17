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
    
    @State var path = NavigationPath()
    
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
        NavigationStack(path: $path) {
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
                    Section(ListHelpers.sectionDisplayName(for: section.id)) {
                        ForEach(section) { item in
                            MenuItemListItem(
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
                            Label("Add \"\(searchText)\"", systemImage: "plus")
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
            .onChange(of: currentList) { _, list in
                if list == nil {
                    onlyShowSelectedItems = false
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
            .navigationTitle("Menu")
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
                    Button {
                        let newItem = StorageProvider.shared.saveMenuItem(named: "")
                        selectedItem = newItem
                    } label: {
                        Image(systemName: "plus")
                    }
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
                // should hide the grocery list here
                MenuItemListDetailsView(path: $path, list: list, hideGroceryList: true)
            }
        }
    }
}

#Preview {
    MenuItemsListView()
        .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext)
}
