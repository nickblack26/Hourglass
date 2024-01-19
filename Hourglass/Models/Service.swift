import Foundation
import SwiftData

@Model
final class Service {
    var name: String = ""
    var amount: Decimal = 0
    var notes: String?
    var hourCap: Int?
    var maxRevisions: Int?
    var quantity: Decimal?
    var total: Decimal {
        amount * (quantity ?? 1)
    }
    
    var project: Project?
    
    init(
        name: String = "",
        amount: Decimal = 0,
        notes: String? = nil,
        hourCap: Int? = nil,
        maxRevisions: Int? = nil,
        quantity: Decimal? = nil,
        project: Project?
    ) {
        self.name = name
        self.amount = amount
        self.notes = notes
        self.hourCap = hourCap
        self.maxRevisions = maxRevisions
        self.quantity = quantity
        self.project = project
    }
}
