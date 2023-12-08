import Foundation
import SwiftData

@Model
class TeamModel {
    @Attribute(.unique) var name: String
    var details: String?
    var members: [MemberModel]
    var projects: [ProjectModel]
    
    init(name: String, details: String? = nil, members: [MemberModel] = [], projects: [ProjectModel] = []) {
        self.name = name
        self.details = details
        self.members = members
        self.projects = projects
    }
}
