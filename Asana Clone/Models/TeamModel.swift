import Foundation
import SwiftData

@Model
class TeamModel {
    var name: String
    var details: String?
    
    @Relationship(deleteRule: .nullify, inverse: \MemberModel.projects) 
    var members: [MemberModel]
    
    @Relationship(deleteRule: .nullify, inverse: \ProjectModel.team)
    var projects: [ProjectModel]
    
    @Relationship(deleteRule: .nullify, inverse: \CommentModel.teams)
    var messages: [CommentModel]
    
    init(
        name: String,
        details: String? = nil,
        members: [MemberModel] = [],
        projects: [ProjectModel] = [],
        messages: [CommentModel] = []
    ) {
        self.name = name
        self.details = details
        self.members = members
        self.projects = projects
        self.messages = messages
    }
}
