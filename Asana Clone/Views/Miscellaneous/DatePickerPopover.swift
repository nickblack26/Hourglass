//
//  DatePickerPopover.swift
//  Asana Clone
//
//  Created by Nick Black on 12/14/23.
//

import SwiftUI

struct DatePickerPopover: View {
    @Binding var date: Date?
    
    var body: some View {
        DatePicker(
            "Date picker",
            selection: Binding(
                get: { return date ?? Date() },
                set: { newValue in
                    date = newValue
                }
            ),
            displayedComponents: .date
        )
        .datePickerStyle(.graphical)
    }
}

#Preview {
    DatePickerPopover(date: .constant(Date()))
}
