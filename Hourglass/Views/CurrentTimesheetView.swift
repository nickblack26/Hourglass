import SwiftUI

struct CurrentTimesheetView: View {
    @State private var timeFormatter = ElapsedTimeFormatter()
    var color: ThemeColor
    var startDate: TimeInterval
    var name: String
    
    var body: some View {
        HStack {
            Image(systemName: "stopwatch")
            Text(
                NSNumber(value: startDate),
                formatter: timeFormatter
            )
            
            Text(name)
                .padding(.leading)
        }
        .padding()
        .background(
            .customizationGreenHover,
            in: .rect(
                topLeadingRadius: 4,
                topTrailingRadius: 4
            )
        )
    }
}

#Preview {
    CurrentTimesheetView(
        color: .green,
        startDate: 0,
        name: "Update Po'boys Menu"
    )
}
