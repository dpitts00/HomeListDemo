//
//  MockFavoriteRestaurantsListView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/27/25.
//

import SwiftUI

struct MockFavoriteRestaurantsListView: View {
    @State var query: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("$$") {
                    Button {
                        
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Hot 'n Spicy")
                                    .font(.headline)
                                Text("dinner")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text("$$")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Swad")
                                    .font(.headline)
                                Text("dinner")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text("$$")
                        }
                    }
                    
                }
                
                Section("$$$") {
                    Button {
                        
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Culvers")
                                    .font(.headline)
                                Text("lunch")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text("$$$")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Yako Sushi")
                                    .font(.headline)
                                Text("lunch, dinner")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text("$$$")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("La Choza del Viejo")
                                    .font(.headline)
                                Text("dinner")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text("$$$")
                        }
                    }
                }
            }
            .navigationTitle("Favorite Restaurants")
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
            .searchable(text: $query, placement: .automatic, prompt: Text("Restaurant or menu item name?"))
        }
    }
}

#Preview {
    MockFavoriteRestaurantsListView()
}
