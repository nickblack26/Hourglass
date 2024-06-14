import SwiftUI

/// Provides a single view to show formatted dates on screen
/// - Parameters:
///     - date: The date you're wanting to display.
///     - dateStyle: Override date style
///     - timeStyle: Override time style
struct FormattedDateField: View {
    var date: Date
    var dateStyle: Date.FormatStyle.DateStyle = .abbreviated
    var timeStyle: Date.FormatStyle.TimeStyle = .shortened
    
    init(
        date: Date,
        dateStyle: Date.FormatStyle.DateStyle = .abbreviated,
        timeStyle: Date.FormatStyle.TimeStyle = .shortened
    ) {
        self.date = date
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
    
    var body: some View {
        Text(
            date,
            format: Date.FormatStyle(
                date: dateStyle,
                time: timeStyle
            )
        )
    }
}

#Preview {
    FormattedDateField(date: .now)
}
