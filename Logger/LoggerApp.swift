//
//  LoggerApp.swift
//  Logger
//
//  Created by Zachary Cohen on 7/26/25.
//

import SwiftUI
import SwiftData

@main
struct LoggerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            LogItem.self,
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
