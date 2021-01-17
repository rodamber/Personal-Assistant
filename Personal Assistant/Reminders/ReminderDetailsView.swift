import CoreData
import SwiftUI

struct ReminderDetailsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var title = ""
    @State private var notes = ""
    @State private var alertDate: Date?
    @State private var showCancelAlert = false
    
    // maybe could be done with a property wrapper on the changing values
    private var changed: Bool {
        get {
            title != "" || notes != "" || alertDate != nil
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Título", text: $title)
                    TextField("Notas", text: $notes)
                }
                Section {
                    ToggleableDatePicker(date: $alertDate)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Detalhes", displayMode: .inline)
            .alert(isPresented: $showCancelAlert) {
                cancelAlert()
            }
            .toolbar {
                cancelButton()
                okButton()
            }
        }
    }

    private func cancelButton() -> some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancelar") {
                if changed {
                    showCancelAlert = true
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    private func cancelAlert() -> Alert {
        Alert(
            title: Text("Ignorar Alterações?"),
            primaryButton: .cancel(Text("Não")),
            secondaryButton: .destructive(Text("Sim")) {
                presentationMode.wrappedValue.dismiss()
            })
    }
    
    private func okButton() -> some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button("OK") {
                addReminder()
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
        }
    }
    
    private func addReminder() {
        let reminder = Reminder(context: viewContext)
        
        reminder.title = title
        reminder.notes = notes
        reminder.alertDate = alertDate
        reminder.creationDate = reminder.creationDate ?? Date()
        reminder.completed = false
        
        try! viewContext.save()
    }
}

struct ReminderDetails_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDetailsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environment(\.colorScheme, .dark)
    }
}
