import Foundation
import SwiftData

@Model
final class Story {
    let type: String?
    let created_at: Date
    let text: String?
    let source: String?
    let project: Project?
    let task: aTask?
    
    enum CodingKeys: String, CodingKey {
        case id, type, created_at, text, source
    }
    
    init(type: String?, created_at: Date, text: String?, source: String?) {
        self.type = type
        self.created_at = created_at
        self.text = text
        self.source = source
    }
}
