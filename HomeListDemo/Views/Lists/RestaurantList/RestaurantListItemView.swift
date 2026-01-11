//
//  RestaurantListItemView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/10/26.
//

import SwiftUI
import CoreData

struct RestaurantListItemView: View {
    var list: RestaurantList
    
    @State var isCurrent: Bool = false
    @Binding var updatedListsAreCurrent: [Bool]
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    isCurrent.toggle()
                } label: {
                    Image(systemName: isCurrent ? "star.fill" : "star")
                }
                .buttonStyle(.plain)

                Text((list.name ?? "").isEmpty ? "Untitled" : (list.name ?? ""))
                    .opacity((list.name ?? "").isEmpty ? 0.5 : 1.0)
                Spacer()
                Text("\(list.itemCount)")
            }
            .font(.headline)
        }
        .contentShape(.rect)
        .onTapGesture {
            path.append(list)
        }
        .task(id: updatedListsAreCurrent) {
            isCurrent = list.isCurrent
        }
        .onChange(of: isCurrent) { _, isCurrent in
            let lists = StorageProvider.shared.getAllRestaurantLists()

            if isCurrent {
                lists.forEach { list in
                    list.isCurrent = false
                }
            }
            
            list.isCurrent = isCurrent
            StorageProvider.shared.update()
            
            updatedListsAreCurrent = lists.map { $0.isCurrent }
        }
    }
}

#Preview {
    @Previewable
    @State var path = NavigationPath()
    
    RestaurantListItemView(
        list: StorageProvider.shared.getAllRestaurantLists()[0],
        updatedListsAreCurrent: .constant(StorageProvider.shared.getAllRestaurantLists().map { $0.isCurrent }),
        path: $path
    )
}
