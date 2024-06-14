import SwiftUI

struct CurrencyField: View {
    var title: String
    @Binding var amount: Decimal
    var currency: Locale.Currency
    
    init(
        _ title: String = "Amount",
        amount: Binding<Decimal>,
        currency: Locale.Currency = Locale.current.currency ?? .init("USD")
    ) {
        self.title = title
        self._amount = amount
        self.currency = currency
    }
    
    var body: some View {
        TextField(
            title,
            value: $amount,
            format: .currency(code: "USD")
        )
        #if os(iOS)
        .keyboardType(.decimalPad)
        .textFieldStyle(.roundedBorder)
        #endif
    }
}

#Preview {
    CurrencyField(amount: .constant(0))
}
