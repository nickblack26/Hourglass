import SwiftUI
import SwiftData

struct TransactionDetailSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Query(sort: \Project.name) private var projects: [Project]
    @Query(sort: \Merchant.name) private var merchants: [Merchant]
    
    @Bindable var transaction: Transaction
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    init() {
        self.transaction = .init(name: "", date: Date(), total: 0, purpose: "")
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Assign to", selection: $transaction.project) {
                    Text("")
                        .tag(Optional<Project>(nil))
                    
                    ForEach(projects) { project in
                        Text(project.name)
                            .tag(Optional(project))
                    }
                }
            }
            
            Section {
                Grid {
                    GridRow {
                        TextField(
                            "Total",
                            value: $transaction.amount,
                            format: .currency(code: "USD")
                        )
                        
                        DatePicker(
                            "Date",
                            selection: $transaction.date,
                            displayedComponents: .date
                        )
                    }
                    
                    GridRow {
                        TextField(
                            "Merchant",
                            value: $transaction.amount,
                            format: .currency(code: "USD")
                        )
                    }
                }
            }
        }
        .navigationTitle("Transaction Info")
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button("Close", systemImage: "xmark") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    TransactionDetailSheet()
}
