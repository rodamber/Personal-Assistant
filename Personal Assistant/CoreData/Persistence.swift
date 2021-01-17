import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        for i in 0..<10 {
            let newReminder = Reminder(context: viewContext)
            newReminder.creationDate = Date()
            newReminder.title = "Reminder #\(i)"
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Personal_Assistant")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

//func addItem(context: NSManagedObjectContext) {
//    let newItem = Reminder(context: context)
//    newItem.creationDate = Date()
//
//    do {
//        try context.save()
//    } catch {
//        // Replace this implementation with code to handle the error appropriately.
//        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        let nsError = error as NSError
//        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//    }
//}

func deleteItems(context: NSManagedObjectContext, items: FetchedResults<Reminder>, offsets: IndexSet) {
    offsets.map { items[$0] }.forEach(context.delete)

    do {
        try context.save()
    } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
}

