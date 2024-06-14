import Foundation
import SwiftUICore
import SwiftData

// MARK: - Portfolio
@Model
final class Portfolio {
    var id: UUID
    var name: String
    var color: String?
    var createdAt: Date?
    var createdBy: User?
    var currentStatusUpdate: StatusUpdate?
    var dueOn: String?
    var customFields: [CustomField]?
    var members: [User]?
    var owner: User?
    var startOn: Date?
    var workspace: Workspace?
    var permalinkUrl: String?
    var portfolioPublic: Bool?

    init(
        name: String,
        color: String?,
        createdAt: Date?,
        createdBy: User?,
        currentStatusUpdate: StatusUpdate?,
        dueOn: String?,
        customFields: [CustomField]?,
        members: [User]?,
        owner: User?,
        startOn: Date?,
        workspace: Workspace?,
        permalinkUrl: String?,
        portfolioPublic: Bool?
    ) {
        self.id = .init()
        self.name = name
        self.color = color
        self.createdAt = createdAt
        self.createdBy = createdBy
        self.currentStatusUpdate = currentStatusUpdate
        self.dueOn = dueOn
        self.customFields = customFields
        self.members = members
        self.owner = owner
        self.startOn = startOn
        self.workspace = workspace
        self.permalinkUrl = permalinkUrl
        self.portfolioPublic = portfolioPublic
    }
    
    enum Privacy: String, CaseIterable {
        case publicToWorkspace = "Public To Workspace"
        case publicToTeam = "Public To Team"
        case `private`
    }
}
