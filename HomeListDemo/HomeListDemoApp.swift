//
//  HomeListDemoApp.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/27/25.
//

import SwiftUI
import CoreData

@main
struct HomeListDemoApp: App {
    var body: some Scene {
        WindowGroup {
            MenuView()
                .environment(\.managedObjectContext, StorageProvider.shared.persistentContainer.viewContext)
        }
    }
}
