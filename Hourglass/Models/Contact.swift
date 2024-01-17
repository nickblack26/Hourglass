import Foundation
import SwiftData

@Model
final class Contact {
    var name: String = ""
    var email: String = ""
    var role: String?
    var phone: String?
    var client: Client?
    var invoice: Invoice?
    
    init(name: String, email: String, role: String? = nil, phone: String? = nil) {
        self.name = name
        self.email = email
        self.role = role
        self.phone = phone
    }
}
