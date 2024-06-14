import Foundation
import SwiftData

// MARK: - TaskTemplate
@Model
class TaskTemplate {
    var id: UUID
    var name: String?
    var project: Project?
    var template: Template?
    var createdBy: User?
    var createdAt: Date?

    init(name: String?, project: Project?, template: Template?, createdBy: User?) {
        self.id = UUID()
        self.name = name
        self.project = project
        self.template = template
        self.createdBy = createdBy
        self.createdAt = .now
    }
}

// MARK: - Template
@Model
class Template {
    var id: UUID
    var name: String?
    var taskResourceSubtype: String?
    var details: String?
    var htmlDescription: String?
    var memberships: [Project]?
    var relativeStartOn: Int?
    var relativeDueOn: Int?
    var dueTime: String?
    var dependencies: [TaskTemplate]?
    var dependents: [TaskTemplate]?
    var followers: [User]?
    var attachments: [Attachment]?
    var subtasks: [aTask]?
    var customFields: [CustomField]?

    init(
        name: String?,
        taskResourceSubtype: String?,
        details: String?,
        htmlDescription: String?,
        memberships: [Project]?,
        relativeStartOn: Int?,
        relativeDueOn: Int?,
        dueTime: String?,
        dependencies: [TaskTemplate]?,
        dependents: [TaskTemplate]?,
        followers: [User]?,
        attachments: [Attachment]?,
        subtasks: [aTask]?,
        customFields: [CustomField]?
    ) {
        self.id = .init()
        self.name = name
        self.taskResourceSubtype = taskResourceSubtype
        self.details = details
        self.htmlDescription = htmlDescription
        self.memberships = memberships
        self.relativeStartOn = relativeStartOn
        self.relativeDueOn = relativeDueOn
        self.dueTime = dueTime
        self.dependencies = dependencies
        self.dependents = dependents
        self.followers = followers
        self.attachments = attachments
        self.subtasks = subtasks
        self.customFields = customFields
    }
    
    enum SubType: String, CaseIterable {
        case defaultTask, milestoneTask, approvalTask
    }
}
