//
//  MenuItemsListView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI
import CoreData

struct MenuItemsListView: View {
    @SectionedFetchRequest(fetchRequest: MenuItem.menuItemsByMeal, sectionIdentifier: \MenuItem.meal)
    var sectionedItems: SectionedFetchResults<String?, MenuItem>
    
    @State var searchText: String = ""
    @State var showFilter: Bool = false
    @State var showSort: Bool = false
    
    @State var selectedItem: MenuItem?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sectionedItems) { section in
                    Section(Meal.init(rawValue: section.id ?? "a")?.displayName ?? "-") {
                        ForEach(section) { menuItem in
                            MenuItemListItem(menuItem: menuItem, action: { selectedItem = menuItem })
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
            .navigationTitle("Menu Items")
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
        }
    }
}

#Preview {
    MenuItemsListView()
        .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext)
}
