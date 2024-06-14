import Foundation
import SwiftData

@Model
final class Transaction {
    var id: UUID
    var name: String = ""
    var date: Date = Date()
    var amount: Decimal = 0
    var taxAmount: Decimal?
    var taxType: TaxType = TaxType.amount
    var taxLabel: String?
    var project: Project?
    var merchant: Merchant?
    var purpose: String = ""
    var note: String?
    var createdAt: Date = Date()
	
//	@Relationship(deleteRule: .nullify, inverse: \Invoice.transaction)
//	var invoice: Invoice?
    
    init(
        name: String,
        date: Date,
        total: Decimal,
        taxType: TaxType = TaxType.amount,
        taxLabel: String? = nil,
        taxAmount: Decimal? = nil,
        project: Project? = nil,
        merchant: Merchant? = nil,
        purpose: String,
//        invoice: Invoice? = nil,
        note: String? = nil,
        createdAt: Date = Date()
    ) {
        self.id = .init()
        self.name = name
        self.date = date
        self.amount = total
        self.taxType = taxType
        self.taxLabel = taxLabel
        self.taxAmount = taxAmount
        self.project = project
        self.merchant = merchant
        self.purpose = purpose
//        self.invoice = invoice
        self.note = note
        self.createdAt = createdAt
    }
    
    enum TransactionType: String, CaseIterable, Codable {
        case taxDeductible = "Tax Deductible"
        case billableToClient = "Billable To Client"
    }
    
    enum TaxType: Codable {
        case percentage, amount
        
        var systemImage: String {
            switch self {
            case .percentage:
                "percent"
            case .amount:
                "dollarsign"
            }
        }
    }
}
