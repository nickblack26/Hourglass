import Foundation
import SwiftData

@Model
class MemberModel {
    var name: String
    @Attribute(.unique) var email: String
    var about: String?
    var jobTitle: String?
    var department: String?
    var teams: [TeamModel]?
    
    var projects: [ProjectModel]?
    
    @Relationship(inverse: \TaskModel.assignee)
    var tasks: [TaskModel]?
    
    init(name: String, email: String, about: String? = nil, jobTitle: String? = nil, department: String? = nil, teams: [TeamModel]? = [], projects: [ProjectModel]? = [], tasks: [TaskModel]? = []) {
        self.name = name
        self.email = email
        self.about = about
        self.jobTitle = jobTitle
        self.department = department
        self.teams = teams
        self.projects = projects
        self.tasks = tasks
    }
}
