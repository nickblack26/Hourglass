import SwiftUI

extension Binding where Value == String {
    init(value: Binding<String?>) {
        self.init {
            value.wrappedValue ?? ""
        } set: { newValue in
            value.wrappedValue = newValue
        }
    }
}
