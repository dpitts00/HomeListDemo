//
//  SettingsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 1/14/26.
//

import SwiftUI

enum SettingsPath: String, Hashable, Equatable {
    case ingredients
}

struct SettingsView: View {
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Button {
                    path.append(SettingsPath.ingredients)
                } label: {
                    Text("Edit Ingredients")
                }
            }
            .navigationDestination(for: SettingsPath.self) { settingsPath in
                switch settingsPath {
                case .ingredients:
                    IngredientsListView(path: $path)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
