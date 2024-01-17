import Foundation
import SwiftData

@Model
final class Invoice {
    var name: String = ""
    var number: Int = 1
    var dueDate: Date?
    var customDueDate: DueDate?
    var createdAt: Date = Date.now
	var transaction: Transaction?
	
	var project: Project?
	
    @Relationship(deleteRule: .nullify, inverse: \Contact.invoice)
    var contacts: [Contact]? = []
    
	init(
		name: String,
		number: Int = 1,
		dueDate: Date? = nil,
		customDueDate: DueDate? = nil,
		transaction: Transaction? = nil,
		project: Project? = nil,
		contacts: [Contact]? = nil
	) {
		self.name = name
		self.number = number
		self.dueDate = dueDate
		self.customDueDate = customDueDate
		self.createdAt = Date()
		self.transaction = transaction
		self.project = project
		self.contacts = contacts
	}
    
    enum DueDate: Codable {
        case uponReceipt, uponCompletion
    }
}




