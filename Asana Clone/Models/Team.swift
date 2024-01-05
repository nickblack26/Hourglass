import Foundation
import SwiftData
import CoreTransferable

@Model
class Team: Codable {
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
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
    }
    
    func encode(to encoder: Encoder) throws {
        let container = encoder.container(keyedBy: CodingKeys.self)
        
    }
}

extension Team: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .data)
    }
}
