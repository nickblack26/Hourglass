import Foundation
import SwiftData

@Model
class TaskModel {
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
    var section: SectionModel?
    
    var assignee: MemberModel?
    
    var subtasks: [TaskModel]?
    
    var projects: [ProjectModel]?
    
    var collaborators: [MemberModel]
    
    init(name: String, isCompleted: Bool = false, details: String? = nil, startDate: Date? = nil, endDate: Date? = nil, createdAt: Date = Date(), completedAt: Date? = nil, section: SectionModel? = nil, assignee: MemberModel? = nil, subtasks: [TaskModel]? = [], projects: [ProjectModel]? = [], collaborators: [MemberModel] = []) {
        self.name = name
        self.isCompleted = isCompleted
        self.details = details
        self.startDate = startDate
        self.endDate = endDate
        self.createdAt = createdAt
        self.completedAt = completedAt
        self.section = section
        self.assignee = assignee
        self.subtasks = subtasks
        self.projects = projects
        self.collaborators = collaborators
    }
}
