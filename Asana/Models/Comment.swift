import Foundation
import SwiftData
import CoreTransferable

@Model
final class Comment: Codable {
    // MARK: Generic variables
    var message: String = ""
    var subject: String?
    var sentAt: Date?
    var createdAt: Date = Date()
    var status: Status = Status.Draft
    
    // MARK: Inferred relationships
    var task: Task? // set on task model
    var projects: [Project]? = [] // set on project model
    var teams: [Team]? = [] // set on team model
    
    init(
        subject: String? = nil,
        message: String,
        projects: [Project] = [],
        teams: [Team] = [],
        status: Status = .Draft
    ) {
        self.subject = subject
        self.message = message
        self.projects = projects
        self.teams = teams
        self.sentAt = nil
        self.status = status
    }
    
    enum CodingKeys: String, CodingKey {
        case message
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
    }
    
    func encode(to encoder: Encoder) throws {
        let container = encoder.container(keyedBy: CodingKeys.self)
        
    }
}

extension Comment: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .data)
    }
}

extension Comment {
    enum Status: Codable {
        case Draft
        case Sent
    }
}
