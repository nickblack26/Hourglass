import Foundation
import SwiftData
import SwiftUI

@Model
final class Business {
    var name: String = ""
    var addressLine1: String?
    var addressLine2: String?
    var city: String?
    var postalCode: String?
    var businessPhone: String?
    var taxIdLabel: String?
    var taxIdNumber: Int?
    var color: String 
    var logo: Data?
    var favicon: Data?
    var archived: Bool = false
    
    init(
        name: String,
        addressLine1: String? = nil,
        addressLine2: String? = nil,
        city: String? = nil,
        postalCode: String? = nil,
        businessPhone: String? = nil,
        taxIdLabel: String? = nil,
        taxIdNumber: Int? = nil,
        color: String,
        logo: Data? = nil,
        favicon: Data? = nil,
        archived: Bool
    ) {
        self.name = name
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.postalCode = postalCode
        self.businessPhone = businessPhone
        self.taxIdLabel = taxIdLabel
        self.taxIdNumber = taxIdNumber
        self.color = color
        self.logo = logo
        self.favicon = favicon
        self.archived = archived
    }
}
