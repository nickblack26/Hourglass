import Foundation
import SwiftData
import CoreTransferable

@Model
class Task: Hashable {
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
    @Relationship(deleteRule: .nullify, inverse: \Member.collaboratingTasks)
    var collaborators: [Member]? = []
    
    @Relationship(deleteRule: .cascade, inverse: \Comment.task)
    var comments: [Comment]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \Member.assignedTasks)
    var assignee: Member?
    
    @Relationship(deleteRule: .nullify, inverse: \Task.parentTask)
    var subtasks: [Task]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \Member.likes)
    var likes: [Member]? = []
    
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
        assignee: Member? = nil,
        collaborators: [Member] = [],
        comments: [Comment] = [],
        subtasks: [Task] = [],
        likes: [Member] = []
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
        self.assignee = assignee
        self.collaborators = collaborators
        self.comments = comments
        self.subtasks = subtasks
        self.likes = likes
    }
}

//extension TaskModel: Transferable {
//    static var transferRepresentation: some TransferRepresentation {
//        CodableRepresentation(contentType: .data)
//    }
//}

extension [Task] {
    func updateOrderIndices() {
        for (index, item) in enumerated() {
            item.order = index
        }
    }
}
