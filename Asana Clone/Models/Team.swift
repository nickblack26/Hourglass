import Foundation
import SwiftData

@Model
class Team {
    var name: String = ""
    var details: String?
    
    @Relationship(deleteRule: .nullify, inverse: \Member.teams)
    var members: [Member]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \Project.team)
    var projects: [Project]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \Comment.teams)
    var messages: [Comment]? = []
    
    init(
        name: String,
        details: String? = nil,
        members: [Member] = [],
        projects: [Project] = [],
        messages: [Comment] = []
    ) {
        self.name = name
        self.details = details
        self.members = members
        self.projects = projects
        self.messages = messages
    }
}
