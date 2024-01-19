import Foundation
import SwiftData
import CoreTransferable

@Model
final class aTask: Hashable, Codable {
    // MARK: Generic variables
    var name: String = ""
    var isCompleted: Bool = false
    var order: Int = 0
    var details: String?
    var startDate: Date?
    var endDate: Date?
    var createdAt: Date = Date()
    var completedAt: Date?
    var taskType: TaskType = TaskType.task
    var taskTypeId: String {
        taskType.rawValue
    }
    
    // MARK: Inferred relationships
    // Relationships inferred from parent
    var parentTask: aTask?
    var section: aSection?
   
    // MARK: Explicit relationships
    @Relationship(deleteRule: .cascade, inverse: \Comment.task)
    var comments: [Comment]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \aTask.parentTask)
    var subtasks: [aTask]? = []
    
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
        parentTask: aTask? = nil,
        taskType: TaskType = TaskType.task,
        section: aSection? = nil,
        comments: [Comment] = [],
        subtasks: [aTask] = []
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
        self.taskType = taskType
        self.section = section
        self.comments = comments
        self.subtasks = subtasks
    }
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let _ = try decoder.container(keyedBy: CodingKeys.self)
        
    }
    
    func encode(to encoder: Encoder) throws {
        let _ = encoder.container(keyedBy: CodingKeys.self)
        
    }
}

extension aTask {
    enum TaskType: String, Codable {
        case task = "Task"
        case approval = "Approval"
        case milestone = "Milestone"
    }
}

extension aTask: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .data)
    }
}

//extension Collection where Element: Orderable {
//    mutating func updateOrderIndices() {
//        for (index, item) in enumerated() {
////            self[index].order = item.order
//            item.order = index
//        }
//    }
//}

protocol Orderable {
    var order: Int { get set }
}
