import SwiftUI

struct ReminderRowView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var reminder: Reminder
    
    var body: some View {
        HStack {
            Checkmark(checked: $reminder.completed) { checked in
                reminder.completed = checked

                try! viewContext.save()
            }
            
            VStack(alignment: .leading) {
                Text(reminder.title ?? "")
                    .font(.headline)
                
                if let alertDate = reminder.alertDate {
                    Text("\(alertDate, formatter: dateFormatter)")
                        .font(.subheadline)
                }
            }
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    
    formatter.dateStyle = .full
    formatter.timeStyle = .short
    formatter.doesRelativeDateFormatting = true
    
    return formatter
}()

struct ReminderRow_Previews: PreviewProvider {
    static var previews: some View {
        let moc = PersistenceController.shared.container.viewContext
        let reminder = Reminder(context: moc)
        
        reminder.alertDate = Date()
        reminder.title = "Example Reminder"
        reminder.completed = true
        
        return ReminderRowView(reminder: reminder)
    }
}
