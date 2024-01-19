import SwiftUI

struct CurrencyField: View {
    @Binding var amount: Decimal
    
    var body: some View {
        TextField(
            "Amount",
            value: $amount,
            format: .number.precision(.fractionLength(2))
        )
        .keyboardType(.decimalPad)
        .textFieldStyle(.roundedBorder)
    }
}

#Preview {
    CurrencyField(amount: .constant(0))
}
