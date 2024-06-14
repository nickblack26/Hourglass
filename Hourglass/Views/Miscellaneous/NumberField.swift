import SwiftUI

struct NumberField: View {
    var title: String
    @Binding var value: Int
    var prompt: Text?
    
    init(_ title: String = "Number", value: Binding<Int>, prompt: Text? = nil) {
        self.title = title
        self._value = value
        self.prompt = prompt
    }
    
    var body: some View {
        TextField(
            title,
            value: $value,
            format: .number,
            prompt: prompt
        )
        #if os(iOS)
        .keyboardType(.decimalPad)
        #endif
    }
}

#Preview {
    NumberField(value: .constant(1))
}
