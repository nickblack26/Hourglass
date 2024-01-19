import SwiftUI

struct InvoiceListItemView: View {
    @Environment(\.modelContext) private var context
    var schedule: Project.InvoiceSchedule
    @Bindable var invoice: Invoice
    
    var body: some View {
        Grid {
            GridRow {
                DatePicker(
                    schedule == .once || schedule == .custom ? "Issue date" : "Start invoices",
                    selection: Binding(value: $invoice.sentDate),
                    displayedComponents: .date
                )
                 
                if schedule == .weekly || schedule == .monthly {
                    DatePicker(
                        "End invoices",
                        selection: Binding(value: $invoice.dueDate),
                        displayedComponents: .date
                    )
                }
            }
        }
        .contextMenu {
            Button("Delete", systemImage: "trash", role: .destructive) {
                context.delete(invoice)
            }
        }
    }
}

#Preview {
    InvoiceListItemView(schedule: .weekly, invoice: .init(name: ""))
}
