//
//  Retain_BookApp.swift
//  Retain Book
//
//  Created by Hubert Wojtowicz on 20/07/2025.
//

import SwiftUI

@main
struct Retain_BookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
