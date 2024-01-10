import Foundation
import SwiftData

@Model
final class CustomField: Codable {
    var currencyCode: String?
    var customLabel: String?
    var customLabelPosition: String?
    var dateValue: String?
    var notes: String?
    var displayValue: String?
    var enabled: Bool?
    var format: FieldType = FieldType.singleSelect
    var name: String?
    var numberValue: Double?
    var precision: Int?
    var resourceSubtype: String?
    var textValue: String?
    var type: String?
    @Relationship(deleteRule: .cascade, inverse: \EnumOption.field)
    var enumOptions: [EnumOption]? = []
    
    @Relationship(deleteRule: .cascade, inverse: \EnumOption.field)
    var enumValue: [EnumOption]?
    var task: Task?
    var project: Project?

    enum CodingKeys: String, CodingKey {
        case currencyCode = "currency_code"
        case customLabel = "custom_label"
        case customLabelPosition = "custom_label_position"
        case dateValue = "date_value"
        case notes = "notes"
        case displayValue = "display_value"
        case enabled = "enabled"
        case format = "format"
        case name = "name"
        case numberValue = "number_value"
        case precision = "precision"
        case resourceSubtype = "resource_subtype"
        case textValue = "text_value"
        case type = "type"
    }

    init(
        currencyCode: String? = nil,
        customLabel: String? = nil,
        customLabelPosition: String? = nil,
        dateValue: String? = nil,
        notes: String? = nil,
        displayValue: String? = nil,
        enabled: Bool? = nil,
        format: FieldType = .singleSelect,
        name: String? = nil,
        numberValue: Double? = nil,
        precision: Int? = nil,
        resourceSubtype: String? = nil,
        textValue: String? = nil,
        type: String? = nil
    ) {
        self.currencyCode = currencyCode
        self.customLabel = customLabel
        self.customLabelPosition = customLabelPosition
        self.dateValue = dateValue
        self.notes = notes
        self.displayValue = displayValue
        self.enabled = enabled
        self.format = format
        self.name = name
        self.numberValue = numberValue
        self.precision = precision
        self.resourceSubtype = resourceSubtype
        self.textValue = textValue
        self.type = type
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    }
}

extension CustomField {
    enum FieldType: String, CaseIterable, Codable {
        case singleSelect = "Single-select"
        case multiSelect = "Multi-select"
        case date = "Date"
        case people = "People"
        case text = "Text"
        case number = "Number"
    }
    
    enum NumberFormat: String, CaseIterable, Codable {
        case number, percent, usd, eur, jpy, gbp, cad, aud, mxn, brl, krw, unformatted
    }
}

@Model
final class EnumOption {
    var color: AsanaColor = AsanaColor.none
    var name: String = ""
    var enabled: Bool = true
    var field: CustomField?
    var order: Int = 0
    
    init(color: AsanaColor = AsanaColor.none, name: String, order: Int = 0) {
        self.color = color
        self.name = name
        self.order = order
    }
}

