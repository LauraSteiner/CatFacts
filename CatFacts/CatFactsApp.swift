//
//  CatFactsApp.swift
//  CatFacts
//
//  Created by Laura Steiner on 6/17/25.
//

import SwiftUI
import SwiftData

@main
struct CatFactsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
