//
//  MenuItemListItemView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/8/26.
//

import SwiftUI
import CoreData

struct MenuItemListItemView: View {
    var list: MenuItemList
    
    @State var isCurrent: Bool = false
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

                Text(list.name ?? "")
                Spacer()
                Text("\(list.itemCount)")
            }
            .font(.headline)
        }
        .contentShape(.rect)
        .onTapGesture {
            path.append(list)
        }
        .onAppear {
            isCurrent = list.isCurrent
        }
        .onChange(of: isCurrent) { _, newValue in
            list.isCurrent = newValue
            StorageProvider.shared.update()
        }
    }
}

#Preview {
    @Previewable
    @State var path = NavigationPath()
    
    MenuItemListItemView(
        list: StorageProvider.shared.getAllMenuItemLists()[0],
        path: $path
    )
}
