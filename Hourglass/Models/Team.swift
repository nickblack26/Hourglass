import Foundation
import SwiftData

// MARK: - Team
@Model
class Team {
    var id: UUID
    var name: String?
    var details: String?
    var htmlDescription: String?
    var workspace: Workspace?
    var permalinkUrl: String?
    var visibility: String?
    var editTeamNameOrDescriptionAccessLevel: AccessLevel?
    var editTeamVisibilityOrTrashTeamAccessLevel: AccessLevel?
    var memberInviteManagementAccessLevel: AccessLevel?
    var guestInviteManagementAccessLevel: AccessLevel?
    var joinRequestManagementAccessLevel: AccessLevel?
    var teamMemberRemovalAccessLevel: AccessLevel?

    init(
        name: String?,
        details: String?,
        htmlDescription: String?,
        workspace: Workspace?,
        permalinkUrl: String?,
        visibility: String?,
        editTeamNameOrDescriptionAccessLevel: AccessLevel?,
        editTeamVisibilityOrTrashTeamAccessLevel: AccessLevel?,
        memberInviteManagementAccessLevel: AccessLevel?,
        guestInviteManagementAccessLevel: AccessLevel?,
        joinRequestManagementAccessLevel: AccessLevel?,
        teamMemberRemovalAccessLevel: AccessLevel?
    ) {
        self.id = .init()
        self.name = name
        self.details = details
        self.htmlDescription = htmlDescription
        self.workspace = workspace
        self.permalinkUrl = permalinkUrl
        self.visibility = visibility
        self.editTeamNameOrDescriptionAccessLevel = editTeamNameOrDescriptionAccessLevel
        self.editTeamVisibilityOrTrashTeamAccessLevel = editTeamVisibilityOrTrashTeamAccessLevel
        self.memberInviteManagementAccessLevel = memberInviteManagementAccessLevel
        self.guestInviteManagementAccessLevel = guestInviteManagementAccessLevel
        self.joinRequestManagementAccessLevel = joinRequestManagementAccessLevel
        self.teamMemberRemovalAccessLevel = teamMemberRemovalAccessLevel
    }
}

extension Team {
    enum AccessLevel: String, CaseIterable, Codable {
        case allTeamMembers, onlyTeamAdmins
    }
}
