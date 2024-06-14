import Foundation
import SwiftData

@Model
final class StatusUpdate {
    var id: UUID
    var htmlText: Data?
    var statusType: StatusType?
    var text: String?
    var title: String = ""
    var createdAt: String?
    var hearted: Bool?
    var modifiedAt: String?
    var numHearts: Int?
    var numLikes: Int?
	var goal: Goal?
    
    var project: Project?
    
    @Relationship(deleteRule: .cascade, inverse: \StatusSection.statusUpdate)
    var sections: [StatusSection]? = []
    
    init(
        htmlText: Data? = nil,
        statusType: StatusType? = nil,
        text: String? = nil,
        title: String,
        createdAt: String? = nil,
        hearted: Bool? = nil,
        modifiedAt: String? = nil,
        numHearts: Int? = nil,
        numLikes: Int? = nil
    ) {
        self.id = .init()
        self.htmlText = htmlText
        self.statusType = statusType
        self.text = text
        self.title = title
        self.createdAt = createdAt
        self.hearted = hearted
        self.modifiedAt = modifiedAt
        self.numHearts = numHearts
        self.numLikes = numLikes
    }
}

enum StatusType: String, CaseIterable, Codable {
    case onTrack = "On track"
    case atRisk = "At risk"
    case offTrack = "Off track"
    case onHold = "On Hold"
    case complete = "Complete"
}


