//
//  MockMenuItemsListView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/27/25.
//

import SwiftUI

struct MockMenuItemsListView: View {
    @State var query: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("breakfast") {
                    Button {
                        
                    } label: {
                        HStack {
                            Text("waffles and blueberries")
                            Spacer()
                            Text("$")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("egg sandwich")
                            Spacer()
                            Text("$$")
                        }
                    }
                    
                }
                
                Section("lunch") {
                    Button {
                        
                    } label: {
                        HStack {
                            Text("uncrustables")
                            Spacer()
                            Text("$")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("pasta salad")
                            Spacer()
                            Text("$$")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("pita and hummus")
                            Spacer()
                            Text("$$")
                        }
                    }
                }
                
                Section("dinner") {
                    Button {
                        
                    } label: {
                        HStack {
                            Text("zucchini spaghetti")
                            Spacer()
                            Text("$")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("dumplings and sushi")
                            Spacer()
                            Text("$$")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("chicken soup")
                            Spacer()
                            Text("$$")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("frozen pizza and caesar salad")
                            Spacer()
                            Text("$$$")
                        }
                    }
                    
                }
                
                Section("snacks") {
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Pringles")
                            Spacer()
                            Text("$")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Apples")
                            Spacer()
                            Text("$")
                        }
                    }
                    
                }
                
            }
            .navigationTitle("Menu Items")
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
            .searchable(text: $query, placement: .automatic, prompt: Text("Menu item name?"))
        }
    }
}

#Preview {
    MockMenuItemsListView()
}
