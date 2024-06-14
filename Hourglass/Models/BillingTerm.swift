import Foundation
import SwiftData

// MARK: - BillingTerm
@Model
class BillingTerm {
    var id: Int?
    var serviceType: Int?
    var name: String?
    var quantity: Int?
    var rate: Int?
    var rateType: Int?
    var status: Int?
    var projectId: Int?

    init(id: Int?, serviceType: Int?, name: String?, quantity: Int?, rate: Int?, rateType: Int?, status: Int?, projectId: Int?) {
        self.id = id
        self.serviceType = serviceType
        self.name = name
        self.quantity = quantity
        self.rate = rate
        self.rateType = rateType
        self.status = status
        self.projectId = projectId
    }
}
