import Foundation
import SwiftUICore
import SwiftData

// MARK: - CustomField
@Model
class CustomField {
    var id: UUID
    var createdBy: User?
    var currencyCode: String?
    var customLabel: String?
    var customLabelPosition: String?
    var dateValue: Date?
    var details: String?
    var displayValue: String?
    var enabled: Bool?
    var enumOptions: [EnumOption]?
    var enumValue: EnumOption?
    var format: String?
    var hasNotificationsEnabled: Bool?
    var isFormulaField: Bool?
    var isGlobalToWorkspace: Bool?
    var isValueReadOnly: Bool?
    var multiEnumValues: [EnumOption]?
    var name: String
    var numberValue: Double?
    var peopleValue: [User]?
    var precision: Int?
    var resourceSubtype: SubType?
    var textValue: String?
    var type: String?
    
    // MARK: Object Relationships
    var task: aTask?
    
    init(
        createdBy: User?,
        currencyCode: String? = nil,
        customLabel: String? = nil,
        customLabelPosition: String? = nil,
        dateValue: Date? = nil,
        details: String? = nil,
        displayValue: String? = nil,
        enabled: Bool? = nil,
        enumOptions: [EnumOption]? = nil,
        enumValue: EnumOption? = nil,
        format: String? = nil,
        hasNotificationsEnabled: Bool? = nil,
        isFormulaField: Bool? = nil,
        isGlobalToWorkspace: Bool? = nil,
        isValueReadOnly: Bool? = nil,
        multiEnumValues: [EnumOption]? = nil,
        name: String,
        numberValue: Double? = nil,
        peopleValue: [User]? = nil,
        precision: Int? = nil,
        resourceSubtype: SubType,
        textValue: String? = nil
    ) {
        self.id = .init()
        self.createdBy = createdBy
        self.currencyCode = currencyCode
        self.customLabel = customLabel
        self.customLabelPosition = customLabelPosition
        self.dateValue = dateValue
        self.details = details
        self.displayValue = displayValue
        self.enabled = enabled
        self.enumOptions = enumOptions
        self.enumValue = enumValue
        self.format = format
        self.hasNotificationsEnabled = hasNotificationsEnabled
        self.isFormulaField = isFormulaField
        self.isGlobalToWorkspace = isGlobalToWorkspace
        self.isValueReadOnly = isValueReadOnly
        self.multiEnumValues = multiEnumValues
        self.name = name
        self.numberValue = numberValue
        self.peopleValue = peopleValue
        self.precision = precision
        self.resourceSubtype = resourceSubtype
        self.textValue = textValue
    }
    
    enum SubType: String, CaseIterable, Codable {
        case text, `enum`, multiEnum, number, date, people
    }
}


@Model
final class EnumOption {
    var name: String
    var enabled: Bool
    var color: String
    var insertBefore: String?
    var insertAfter: String?
    
    init(
        name: String,
        enabled: Bool,
        color: String,
        insertBefore: String? = nil,
        insertAfter: String? = nil
    ) {
        self.name = name
        self.enabled = enabled
        self.color = color
        self.insertBefore = insertBefore
        self.insertAfter = insertAfter
    }
}
