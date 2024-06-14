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
    
    static var keyPaths: [String: PartialKeyPath<aTask>] {
        return [
            "Name" : \aTask.name,
            "Is Completed" : \aTask.isCompleted,
            "Start Date" : \aTask.startDate,
            "End Date" : \aTask.endDate,
            "Created At" : \aTask.createdAt,
            "Completed At" : \aTask.completedAt,
            "Task Type" : \aTask.taskType
        ]
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

let currentDate = Date()
let calendar = Calendar.current
let currentWeek = calendar.dateInterval(of: .weekOfYear, for: currentDate)!
let nextWeekDay = calendar.date(byAdding: .day, value: 7, to: currentDate)!
let nextWeek = calendar.dateInterval(of: .weekOfYear, for: nextWeekDay)!

extension aTask {
    enum TaskType: String, Codable {
        case task = "Task"
        case approval = "Approval"
        case milestone = "Milestone"
    }
	
	enum Filter: String, CaseIterable, Codable {
		case incomplete
		case complete
		case dueThisWeek
		case dueNextWeek
	}
}

extension aTask: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .data)
    }
}

// Helper functions
extension aTask {
    func updateSection(section: aSection?) {
        self.section?.tasks?.removeAll(where: { $0 == self })
        section?.tasks?.append(self)
    }
}

extension [aTask] {
    mutating func replaceItem(draggingTask: aTask?, droppingTask: aTask, section: aSection?) {
        if let sourceIndex = self.firstIndex(where: { $0 == draggingTask }), let destinationIndex = self.firstIndex(where: { $0 == droppingTask }) {
            let sourceItem = self.remove(at: sourceIndex)
            sourceItem.section = section
            self.insert(sourceItem, at: destinationIndex)
            self.updateOrderIndices()
        }
    }
    
    func appendTask(_ section: aSection) {
        
    }
    
    func updateOrderIndices() {
        for (index, item) in enumerated() {
            item.order = index
        }
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
