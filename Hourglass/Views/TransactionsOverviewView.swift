import SwiftUI
import SwiftData

struct TransactionsOverviewView: View {
    @Environment(\.modelContext) private var context
    @Environment(HourglassManager.self) private var asana
    @Query private var transactions: [Transaction]
    
    var body: some View {
        let total: Float = transactions.reduce(0) { partialResult, transaction in
            if let invoice = transaction.invoice {
                return partialResult - transaction.total
            }
            
            return partialResult + transaction.total
        }
        
        Card {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Profit before taxes")
                    Text(total, format: .currency(code: "USD"))
                }
            }
            
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button("New expense", systemImage: "minus") {
                    withAnimation(.snappy) {
                        let expense = Transaction(
                            name: "",
                            date: Date(),
                            total: 0.00,
                            purpose: ""
                        )
                        context.insert(expense)
                        asana.selectedTransaction = expense
                    }
                }
            
                Button("New income", systemImage: "plus") {
                    
                }
            
                Button("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                    
                }
            
                Button("Sort", systemImage: "arrow.up.arrow.down") {
                    
                }
            
                Button("Export", systemImage: "square.and.arrow.up") {
                    
                }
            }
        }
    }
}

#Preview {
    TransactionsOverviewView()
}
