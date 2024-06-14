import Foundation
import SwiftData

@Model
final class LineItem {
    var quantity: Decimal?
    var rate: Decimal = 0
    var amount: Decimal {
        (quantity ?? 1) * (rate)
    }
    var pricingStructure: Structure = Structure.flatFee
    var type: LineItemType = LineItemType.invoiceItem
    var periodStart: Date?
    var periodEnd: Date?
    var notes: String?
    var name: String = ""
    
    var invoice: Invoice?
    var project: Project?
    
    init(
        name: String,
        quantity: Decimal? = nil,
        pricingStructure: Structure = Structure.flatFee,
        type: LineItemType = LineItemType.invoiceItem,
        periodStart: Date? = nil,
        periodEnd: Date? = nil,
        notes: String? = nil,
        invoice: Invoice? = nil,
        project: Project? = nil
    ) {
        self.name = name
        self.quantity = quantity
        self.type = type
        self.periodStart = periodStart
        self.periodEnd = periodEnd
        self.notes = notes
        self.invoice = invoice
    }
}

extension LineItem {
    enum LineItemType: String, Codable {
        case invoiceItem
        case subscription
    }
    
    enum Structure: String, CaseIterable, Codable {
        case flatFee = "Flat fee"
        case hourly = "Per hour"
        case day = "Per day"
        case word = "Per word"
        case page = "Per page"
    }
}
