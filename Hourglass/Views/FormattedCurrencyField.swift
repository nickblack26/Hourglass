import SwiftUI

/// Provides a single view to show formatted currency on the screen
/// - Parameters:
///     - value: The value, in Decimal format, you're wanting to display.
///     - currency: Override currency that you're wanting to display
struct FormattedCurrencyField: View {
    var value: Decimal
    var currency: Locale.Currency = Locale.current.currency ?? .init("USD")
    
    init(
        _ value: Decimal,
        currency: Locale.Currency = Locale.current.currency ?? .init("USD")
    ) {
        self.value = value
        self.currency = currency
    }
    
    var body: some View {
        Text(
            value,
            format: .currency(
                code: currency.identifier
            )
        )
    }
}

#Preview {
    FormattedCurrencyField(1.20)
}
