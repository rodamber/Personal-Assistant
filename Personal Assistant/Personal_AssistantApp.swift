//
//  Personal_AssistantApp.swift
//  Personal Assistant
//
//  Created by Rodrigo Bernardo on 14/01/2021.
//

import SwiftUI

@main
struct Personal_AssistantApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
