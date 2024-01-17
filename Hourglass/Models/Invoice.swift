import Foundation
import SwiftData

@Model
final class Invoice {
    var name: String = ""
    var number: Int = 1
    var client: Client?
    var dueDate: Date?
    var customDueDate: DueDate?
    var createdAt: Date = Date.now
	var transaction: Transaction?
	
    @Relationship(deleteRule: .nullify, inverse: \Contact.invoice)
    var contacts: [Contact]? = []
    
    init(name: String) {
        self.name = name
    }
    
    enum DueDate: Codable {
        case uponReceipt, uponCompletion
    }
}




