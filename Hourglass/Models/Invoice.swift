import Foundation
import SwiftData

@Model
final class Invoice {
    var name: String = ""
    var number: Int = 1
    var customDueDate: DueDate?
    var transaction: Transaction?
    var status: Status = Status.draft
    var memo: String?
    
//    var subscription: Subscription?
    var project: Project?
    
    // MARK: Dates
    var createdAt: Date = Date.now
    var dueDate: Date?
    var sentDate: Date?
    
    @Relationship(deleteRule: .cascade, inverse: \LineItem.invoice)
    var lines: [LineItem]? = []
    
	init(
		name: String,
		number: Int = 1,
        sentDate: Date? = nil,
		dueDate: Date? = nil,
		customDueDate: DueDate? = nil,
		transaction: Transaction? = nil,
		project: Project? = nil
	) {
		self.name = name
        self.number = number
		self.sentDate = sentDate
		self.dueDate = dueDate
		self.customDueDate = customDueDate
		self.createdAt = Date()
		self.transaction = transaction
		self.project = project
	}
    
    enum DueDate: Codable {
        case uponReceipt, uponCompletion
    }
}

extension Invoice {
    enum Status: String, CaseIterable, Codable {
        case draft
        case open
        case paid
        case void
    }
}
