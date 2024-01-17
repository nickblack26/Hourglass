import Foundation
import SwiftData

@Model
final class Client {
    var name: String = ""
    var addressLine1: String?
    var addressLine2: String?
    var city: String?
    var postalCode: String?
    var taxIdLabel: String?
    var archived: Bool = false
    var taxIdNumber: Int?
    
    @Relationship(deleteRule: .cascade, inverse: \Contact.client)
    var contacts: [Contact]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \Project.client)
    var projects: [Project]? = []
	
    init(
        name: String,
        addressLine1: String? = nil,
        addressLine2: String? = nil,
        city: String? = nil,
        postalCode: String? = nil,
        taxIdLabel: String? = nil,
        taxIdNumber: Int? = nil,
        contacts: [Contact] = [],
        projects: [Project] = []
    ) {
        self.name = name
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.postalCode = postalCode
        self.taxIdLabel = taxIdLabel
        self.taxIdNumber = taxIdNumber
        self.contacts = contacts
        self.projects = projects
    }
}
