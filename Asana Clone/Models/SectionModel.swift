import Foundation
import SwiftData

@Model
class SectionModel {
    // MARK: Generic variables
    var name: String
    var order: Int = 0
    var createdAt: Date = Date()
    
    // MARK: Inferred relationships
    var project: ProjectModel? // set on project model
    var member: MemberModel? // set on member model
    var tasks: [TaskModel] // inferred from swift data
    
    init(
        name: String,
        order: Int,
        project: ProjectModel? = nil,
        member: MemberModel? = nil,
        tasks: [TaskModel] = []
    ) {
        self.name = name
        self.order = order
        self.project = project
        self.member = member
        self.tasks = tasks
        self.createdAt = Date()
    }
}
