import Foundation
import SwiftData

@Model
final class Comment {
    // MARK: Generic variables
    var message: String = ""
    var subject: String?
    var sentAt: Date?
    var createdAt: Date = Date()
    var status: Status = Status.Draft
    
    // MARK: Inferred relationships
    var sender: Member? // set on member model
    var task: Task? // set on task model
    var projects: [Project] = [] // set on project model
    var teams: [Team] = [] // set on team model
    var members: [Member] = [] // set on member model
    
    @Relationship(inverse: \Member.mentions)
    var mentions: [Member] = []
    
    init(
        subject: String? = nil,
        message: String,
        sender: Member,
        members: [Member] = [],
        projects: [Project] = [],
        teams: [Team] = [],
        status: Status = .Draft
    ) {
        self.subject = subject
        self.message = message
        self.sender = sender
        self.members = members
        self.projects = projects
        self.teams = teams
        self.sentAt = nil
        self.status = status
    }
}

extension Comment {
    enum Status: Codable {
        case Draft
        case Sent
    }
}

