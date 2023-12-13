import Foundation
import SwiftData
import CoreTransferable

@Model
class TaskModel: Hashable {
    // MARK: Generic variables
    var name: String
    var isCompleted: Bool {
        didSet {
            if isCompleted {
                completedAt = Date()
            }
        }
    }
    var details: String?
    var startDate: Date?
    var endDate: Date?
    var createdAt: Date
    var completedAt: Date?
    
    // MARK: Inferred relationships
    // Relationships inferred from parent
    var parentTask: TaskModel?
    var projects: [ProjectModel]?
    var section: SectionModel?
   
    // MARK: Explicit relationships
    @Relationship(deleteRule: .nullify, inverse: \MemberModel.collaboratingTasks)
    var collaborators: [MemberModel]?
    
    @Relationship(deleteRule: .cascade, inverse: \CommentModel.task)
    var comments: [CommentModel]?
    
    @Relationship(deleteRule: .nullify, inverse: \MemberModel.assignedTasks)
    var assignee: MemberModel?
    
    @Relationship(deleteRule: .nullify, inverse: \TaskModel.parentTask)
    var subtasks: [TaskModel]
    
    init(
        name: String,
        isCompleted: Bool = false,
        details: String? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        createdAt: Date = Date(),
        completedAt: Date? = nil,
        parentTask: TaskModel? = nil,
        projects: [ProjectModel] = [],
        section: SectionModel? = nil,
        assignee: MemberModel? = nil,
        collaborators: [MemberModel] = [],
        comments: [CommentModel] = [],
        subtasks: [TaskModel] = []
    ) {
        self.name = name
        self.isCompleted = isCompleted
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
    }
}

//extension TaskModel: Transferable {
//    static var transferRepresentation: some TransferRepresentation {
//        CodableRepresentation(contentType: .data)
//    }
//}
