import Foundation
import SwiftData

@Model
class MemberModel {
    // MARK: Generic variables
    var name: String
    @Attribute(.unique) var email: String
    var about: String?
    var notepad: String?
    var jobTitle: String?
    var department: String?
    var widgets: [WidgetModel]
    
    // MARK: Inferred relationships
    var teams: [TeamModel]? // set on team model
    var projects: [ProjectModel]? // set on project model
    var assignedTasks: [TaskModel]? // set on task model
    var collaboratingTasks: [TaskModel]? // set on task model
    var mentions: [CommentModel]? // set on comment model
    var sections: [SectionModel]? // inferred by swift data
    
    // MARK: Explicit relationships
    @Relationship(deleteRule: .nullify, inverse: \CommentModel.sender)
    var sentComments: [CommentModel]?
    
    @Relationship(deleteRule: .nullify, inverse: \CommentModel.members)
    var receivedComments: [CommentModel]?
    
    init(
        name: String,
        email: String,
        about: String? = nil,
        notepad: String? = nil,
        jobTitle: String? = nil,
        department: String? = nil,
        widgets: [WidgetModel] = [],
        teams: [TeamModel] = [],
        projects: [ProjectModel] = [],
        assignedTasks: [TaskModel] = [],
        collaboratingTasks: [TaskModel] = [],
        mentions: [CommentModel] = [],
        sections: [SectionModel] = [],
        sentComments: [CommentModel] = [],
        receivedComments: [CommentModel] = []
    ) {
        self.name = name
        self.email = email
        self.about = about
        self.notepad = notepad
        self.jobTitle = jobTitle
        self.widgets = widgets
        self.teams = teams
        self.projects = projects
        self.assignedTasks = assignedTasks
        self.collaboratingTasks = collaboratingTasks
        self.mentions = mentions
        self.sections = sections
        self.sentComments = sentComments
        self.receivedComments = receivedComments
    }
}
