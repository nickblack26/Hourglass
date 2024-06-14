import Foundation
import SwiftData

// MARK: - TaxDefinition
@Model
class TaxDefinition {
    var id: UUID
    var name: String?
    var totalTaxPercentage: Int?
    var totalTaxFixed: Int?
    var identificationNumber: String?

    init(name: String?, totalTaxPercentage: Int?, totalTaxFixed: Int?, identificationNumber: String?) {
        self.id = .init()
        self.name = name
        self.totalTaxPercentage = totalTaxPercentage
        self.totalTaxFixed = totalTaxFixed
        self.identificationNumber = identificationNumber
    }
}
