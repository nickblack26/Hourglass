import Foundation
import SwiftData

// MARK: - Workspace
@Model
final class Workspace {
    var id: UUID
    var name: String?
    var emailDomains: [String]?
    var isOrganization: Bool?
    
    @Relationship(deleteRule: .cascade, inverse: \User.workspaces)
    var members: [User]?
    
    @Relationship(deleteRule: .cascade, inverse: \Team.workspace)
    var teams: [Team]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case emailDomains = "email_domains"
        case isOrganization = "is_organization"
    }

    init(
        name: String? = nil,
        emailDomains: [String]? = nil,
        isOrganization: Bool? = nil,
        members: [User]? = nil
    ) {
        self.id = .init()
        self.name = name
        self.emailDomains = emailDomains
        self.isOrganization = isOrganization
    }
}
