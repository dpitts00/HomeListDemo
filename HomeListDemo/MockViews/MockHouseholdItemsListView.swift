//
//  MockHouseholdItemsListView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/27/25.
//

import SwiftUI

struct MockHouseholdItemsListView: View {
    @State var query: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("kitchen") {
                    Button {
                        
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("dish soap")
                                    .font(.headline)
                            }
                            Spacer()
                        }
                    }
                }
                
                Section("bathroom") {
                    Button {
                        
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("deodorant")
                                    .font(.headline)
                                Text("daniel")
                                    .font(.subheadline)
                            }
                            Spacer()
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("body wash")
                                    .font(.headline)
                                Text("daniel, katie")
                                    .font(.subheadline)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Household Items")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
            }
            .searchable(text: $query, placement: .automatic, prompt: Text("Item name?"))
        }
    }
}

#Preview {
    MockHouseholdItemsListView()
}
