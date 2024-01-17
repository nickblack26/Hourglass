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
    var task: aTask? // set on task model
    var projects: [Project]? = [] // set on project model
    
    init(
        subject: String? = nil,
        message: String,
        projects: [Project] = [],
        status: Status = .Draft
    ) {
        self.subject = subject
        self.message = message
        self.projects = projects
        self.sentAt = nil
        self.status = status
    }
    
    enum CodingKeys: String, CodingKey {
        case message
    }
    
    required init(from decoder: Decoder) throws {
        let _ = try decoder.container(keyedBy: CodingKeys.self)
        
    }
    
    func encode(to encoder: Encoder) throws {
        let _ = encoder.container(keyedBy: CodingKeys.self)
        
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
