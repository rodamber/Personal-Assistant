import SwiftUI

struct Checkmark: View {
    @Binding var checked: Bool
    let action: (Bool) -> Void
    
    var body: some View {
        Button {
            checked.toggle()
        } label: {
            Image(systemName: checked ? "checkmark.circle.fill" : "circle")
        }
    }
}

struct ReminderRowCheckmark_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State var checked = false
        
        var body: some View {
            Checkmark(checked: $checked) { checked in }
        }
    }
}
