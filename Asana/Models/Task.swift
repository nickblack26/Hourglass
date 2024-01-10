import Foundation
import SwiftData
import CoreTransferable

@Model
class Task: Hashable, Codable {
    // MARK: Generic variables
    var name: String = ""
    var isCompleted: Bool = false
    var order: Int = 0
    var details: String?
    var startDate: Date?
    var endDate: Date?
    var createdAt: Date = Date()
    var completedAt: Date?
    
    // MARK: Inferred relationships
    // Relationships inferred from parent
    var parentTask: Task?
    var projects: [Project]? = []
    var section: Section?
   
    // MARK: Explicit relationships
    @Relationship(deleteRule: .cascade, inverse: \Comment.task)
    var comments: [Comment]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \Task.parentTask)
    var subtasks: [Task]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \CustomField.task)
    var customFields: [CustomField]? = []
    
    init(
        name: String,
        isCompleted: Bool = false,
        order: Int,
        details: String? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        createdAt: Date = Date(),
        completedAt: Date? = nil,
        parentTask: Task? = nil,
        projects: [Project] = [],
        section: Section? = nil,
        comments: [Comment] = [],
        subtasks: [Task] = []
    ) {
        self.name = name
        self.isCompleted = isCompleted
        self.order = order
        self.details = details
        self.startDate = startDate
        self.endDate = endDate
        self.createdAt = createdAt
        self.completedAt = completedAt
        self.parentTask = parentTask
        self.projects = projects
        self.section = section
        self.comments = comments
        self.subtasks = subtasks
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

extension Task: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .data)
    }
}

extension [Task] {
    func updateOrderIndices() {
        for (index, item) in enumerated() {
            item.order = index
        }
    }
}
