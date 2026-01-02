//
//  MenuItemsListView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI
import CoreData

struct MenuItemsListView: View {
//    @FetchRequest(fetchRequest: MenuItem.menuItemsByName)
//    private var menuItems: FetchedResults<MenuItem>
    
    @SectionedFetchRequest(fetchRequest: MenuItem.menuItemsByMeal, sectionIdentifier: \MenuItem.meal)
    var sectionedMenuItems: SectionedFetchResults<String?, MenuItem>
    
    @State var searchText: String = ""
    @State var showFilter: Bool = false
    @State var showSort: Bool = false
    // sort descriptor
    // ascending
    
    var body: some View {
        NavigationStack {
            List {
//                ForEach(menuItems) { menuItem in
//                    Button {
//                        
//                    } label: {
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(menuItem.nameString)
//                                    .font(.headline)
//                                Text(menuItem.meal ?? "")
//                                    .font(.subheadline)
//                            }
//                            Spacer()
//                            Text(menuItem.priceTierString)
//                        }
//                    }
//                }
                
                ForEach(sectionedMenuItems) { section in
                    Section("\(section.id ?? "untitled section")") {
                        ForEach(section) { menuItem in
                            MenuItemListItem(menuItem: menuItem)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        StorageProvider.shared.deleteMenuItem(menuItem) // do it differently
                                    } label: {
                                        Text("Delete")
                                        Image(systemName: "trash.fill")
                                    }
                                }
                        }
//                        .onDelete { indexSet in
//                            
//                        }
                    }
                }
                    
                    
//                if !menuItems.isEmpty {
                if !sectionedMenuItems.isEmpty {
                    Button(role: .destructive) {
                        StorageProvider.shared.deleteAllMenuItems()
                    } label: {
                        Text("Delete All")
                    }
                }

            }
//            .onChange(of: sortWhatever) // update the sortDescriptors, also can remove the section identifier
            .onChange(of: searchText) {
                _,
                newValue in
                guard !newValue.isEmpty else {
//                    menuItems.nsPredicate = nil
                    sectionedMenuItems.nsPredicate = nil
                    return
                }
                
//                menuItems.nsPredicate = NSPredicate(
                
                sectionedMenuItems.nsPredicate = NSPredicate(
                    format: "%K CONTAINS[cd] %@",
                    argumentArray: [
                        #keyPath(MenuItem.name),
                        newValue
                    ]
                )
                
//                sectionedMenuItems.nsPredicate = MenuItem.filter(\MenuItem.name, keyword: newValue)
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
            .searchable(text: $searchText, placement: .automatic, prompt: Text("Menu item name?"))
            .sheet(isPresented: $showFilter) {
                FilterView<MenuItem>(predicate: $sectionedMenuItems.nsPredicate)
                    .presentationDetents([.medium])
            }
            .sheet(isPresented: $showSort) {
                SortView<MenuItem, String>(
                    sortDescriptors: $sectionedMenuItems.nsSortDescriptors,
                    sectionIdentifier: $sectionedMenuItems.sectionIdentifier
                )
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    MenuItemsListView()
        .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext)
}
