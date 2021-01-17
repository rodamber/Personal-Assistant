import SwiftUI
import CoreData

struct ReminderListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Reminder.creationDate, ascending: true)
        ],
        predicate: nil,
        animation: nil)
    private var reminders: FetchedResults<Reminder>
    
    @State private var showReminderDetails = false

    var body: some View {
        NavigationView {
            List {
                ForEach(reminders) { reminder in
                    ReminderRowView(reminder: reminder)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Lembretes")
            .toolbar {
                Button {
                    showReminderDetails = true
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
            .fullScreenCover(isPresented: $showReminderDetails) {
                ReminderDetailsView()
            }
        }
    }
}

struct ReminderList_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environment(\.colorScheme, .dark)
    }
}
