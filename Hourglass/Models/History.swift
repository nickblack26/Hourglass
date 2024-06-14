import Foundation
import SwiftData

// MARK: - History
@Model
class History {
    var id: Int?
    var invoiceId: Int?
    var action: Int?
    var createdDate: String?
    var refObject: Payment?

    init(id: Int?, invoiceId: Int?, action: Int?, createdDate: String?, refObject: Payment?) {
        self.id = id
        self.invoiceId = invoiceId
        self.action = action
        self.createdDate = createdDate
        self.refObject = refObject
    }
}
