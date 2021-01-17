import SwiftUI

@main
struct Main: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ReminderListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
