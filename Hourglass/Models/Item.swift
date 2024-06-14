import Foundation
import SwiftData

// MARK: - Item
@Model
class Item {
    var id: Int?
    var quantity: Int?
    var details: String?
    var rate: Int?
    var rateType: Int?
    var billingTerm: BillingTerm?

    init(id: Int?, quantity: Int?, details: String?, rate: Int?, rateType: Int?, billingTerm: BillingTerm?) {
        self.id = id
        self.quantity = quantity
        self.details = details
        self.rate = rate
        self.rateType = rateType
        self.billingTerm = billingTerm
    }
}
