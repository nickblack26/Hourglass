import Foundation
import SwiftData

@Model
class Member {
    // MARK: Generic variables
    var name: String = ""
    var email: String = ""
    var about: String?
    var notepad: Data?
    var jobTitle: String?
    var department: String?
    var widgets: [Widget]?
    
    // MARK: Inferred relationships
    var teams: [Team]? = [] // set on team model
    var projects: [Project]? = [] // set on project model
    var assignedTasks: [Task]? = [] // set on task model
    var collaboratingTasks: [Task]? = [] // set on task model
    var mentions: [Comment]? = [] // set on comment model
    var likes: [Task]? = [] // set on task model
    var sections: [Section]? = [] // inferred by swift data
   
    // MARK: Explicit relationships
    @Relationship(deleteRule: .nullify, inverse: \Comment.sender)
    var sentComments: [Comment]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \Comment.members)
    var receivedComments: [Comment]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \Project.owner)
    var ownedProjects: [Project]? = []
    
    init(
        name: String,
        email: String,
        about: String? = nil,
        notepad: Data? = nil,
        jobTitle: String? = nil,
        department: String? = nil,
        widgets: [Widget] = [],
        teams: [Team] = [],
        projects: [Project] = [],
        assignedTasks: [Task] = [],
        collaboratingTasks: [Task] = [],
        mentions: [Comment] = [],
        likes: [Task] = [],
        sections: [Section] = [],
        sentComments: [Comment] = [],
        receivedComments: [Comment] = []
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
        self.likes = likes
        self.sections = sections
        self.sentComments = sentComments
        self.receivedComments = receivedComments
    }
}
