import SwiftUI

struct ToggleableDatePicker: View {
    @Binding var date: Date?
    @State private var showPicker = false
    
    var body: some View {
        Group {
            Toggle(isOn: toggleBinding) {
                toggleLabel()
            }
            .onTapGesture {
                if date != nil {
                    withAnimation {
                        showPicker.toggle()
                    }
                }
            }
            
            if showPicker {
                DatePicker(
                    "Seleciona a data",
                    selection: $date ?? Date(),
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
            }
        }
    }
    
    /// Toggle off => clear date and hide date picker
    /// Toggle on => set date and show date picker
    private var toggleBinding: Binding<Bool> {
        Binding(
            get: { date != nil },
            set: {
                showPicker = $0
                
                if $0 {
                    date = Date(timeIntervalSinceNow: 3600)
                } else {
                    date = nil
                }
            }
        )
    }
    
    private func toggleLabel() -> some View {
        HStack {
            ClockIcon()
            
            VStack(alignment: .leading) {
                Text("Alarme")
                
                if let alertDate = date {
                    Text("\(alertDate, formatter: alertDateFormatter)")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
        }
        .contentShape(Rectangle())
    }
}

private let alertDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    formatter.doesRelativeDateFormatting = true
    
    return formatter
}()

struct AlertDateToggleablePicker_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
            .environment(\.colorScheme, .dark)
    }
    
    struct PreviewWrapper: View {
        @State var date: Date?
        
        var body: some View {
            List {
                Section {
                    ToggleableDatePicker(
                        date: $date
                    )
                }
            }
        }
    }
}
