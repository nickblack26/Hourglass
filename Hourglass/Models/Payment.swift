import Foundation
import SwiftData

// MARK: - Payment
@Model
class Payment {
    var id: Int?
    var createdDate: String?
    var paidDate: String?
    var category: Int?
    var refObjectId: Int?
    var amount: Int?
    var currency: String?
    var status: Int?

    init(id: Int?, createdDate: String?, paidDate: String?, category: Int?, refObjectId: Int?, amount: Int?, currency: String?, status: Int?) {
        self.id = id
        self.createdDate = createdDate
        self.paidDate = paidDate
        self.category = category
        self.refObjectId = refObjectId
        self.amount = amount
        self.currency = currency
        self.status = status
    }
}
