import SwiftUI

struct DateRangeView: View {
    @State private var showDatePicker: Bool = false
    @State private var dateComponents = Set<DateComponents>()
    
    @Binding var startDate: Date?
    @Binding var endDate: Date
    
    var body: some View {
        Button {
            showDatePicker.toggle()
        } label: {
            HStack {
                Image(systemName: "clock.fill")
                    .imageScale(.small)
                
                if let startDate {
                    Text("\(Text(startDate, format: Date.FormatStyle().day())) - ")
                    Text(
                        endDate,
                        format: Date.FormatStyle().day()
                    )
                } else {
                    Text(
                        endDate,
                        format: Date.FormatStyle().day().month()
                    )
                }
            }
        }
        #if os(iOS)
        .popover(isPresented: $showDatePicker, content: {
            MultiDatePicker("Date Picker", selection: $dateComponents)
        })
        #endif
    }
}

#Preview {
    DateRangeView(
        startDate: .constant(nil),
        endDate: .constant(Date())
    )
}
