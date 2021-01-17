import CoreData
import Foundation
import SwiftUI

class Model: ObservableObject {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    @Published var reminders: [Reminder] = []
    
    func fetchReminders() throws {
        let request = NSFetchRequest<Reminder>(entityName: "Reminder")
        let reminders = try context.fetch(request)
        
        self.reminders = Array(reminders)
    }
}
