//
//  ProjectModel.swift
//  Asana Clone
//
//  Created by Nick on 6/24/23.
//

import Foundation
import SwiftData
import SwiftUI

enum ProjectColor: CaseIterable, Codable {
	case none
	case red
	case orange
	case yellowOrange
	case yellow
	case yellowGreen
	case green
	case blueGreen
	case aqua
	case blue
	case indigo
	case purple
	case magenta
	case hotPink
	case pink
	case coolGray
	
	var color: Color {
		switch self {
			case .none: Color(.gray)
			case .red: Color(.red)
			case .orange: Color(.orange)
			case .yellowOrange: Color(.orange)
			case .yellow: Color(.yellow)
			case .yellowGreen: Color(.green)
			case .green: Color(.green)
			case .blueGreen: Color(.teal)
			case .aqua: Color(.teal)
			case .blue: Color(.blue)
			case .indigo: Color(.purple)
			case .purple: Color(.purple)
			case .magenta: Color(.purple)
			case .hotPink: Color(.pink)
			case .pink: Color(.pink)
			case .coolGray: Color(.darkGray)
		}
	}
}

enum ProjectIcon: String, CaseIterable, Codable {
    case board
    case bug
    case calendar
    case graph
    case lightBulb
    case list
    case people
    case rocket
    case star
    case timeline
    
    var icon: String {
        switch self {
        case .board:
            "project_\(self.rawValue)_icon"
        case .bug:
            "project_\(self.rawValue)_icon"
        case .calendar:
            "project_\(self.rawValue)_icon"
        case .graph:
            "project_\(self.rawValue)_icon"
        case .lightBulb:
            "project_\(self.rawValue)_icon"
        case .list:
            "project_\(self.rawValue)_icon"
        case .people:
            "project_\(self.rawValue)_icon"
        case .rocket:
            "project_\(self.rawValue)_icon"
        case .star:
            "project_\(self.rawValue)_icon"
        case .timeline:
            "project_\(self.rawValue)_icon"
        }
    }
}

enum PrivacyStatus: String, CaseIterable, Codable {
	case publicToTeam = "Public to Engineering"
	case publicToMembers = "Public to project members"
	case privateToMe = "Private to me"
	
	var privacyBool: Bool {
		switch self {
			case .publicToTeam:
				return true
			default:
				return false
		}
	}
}

enum ProjectTab: String, CaseIterable, Codable {
    case overview = "Overview"
    case list = "List"
    case board = "Board"
    case timeline = "Timeline"
    case calendar = "Calendar"
    case workflow = "Workflow"
    case dashboard = "Dashboard"
    case messages = "Messages"
    case files = "Files"
    
    var showMenu: Bool {
        switch self {
            case .overview:
                return false
            case .list:
                return true
            case .board:
                return true
            case .timeline:
                return true
            case .calendar:
                return true
            case .workflow:
                return false
            case .dashboard:
                return false
            case .messages:
                return false
            case .files:
                return false
        }
    }
    
    var image: String {
        switch self {
            case .list: return "newProjectList"
            case .board: return "newProjectBoard"
            case .timeline: return "newProjectTimeline"
            case .calendar: return "newProjectCalendar"
            default: return ""
        }
    }
}

enum FirstStep: String, CaseIterable {
	case tasks
	case share
	case workflow
	
	var details: (String, String, String) {
		switch self {
			case .tasks: return ("addTasksIcon", "Start adding tasks", "Assign, set due dates, and get to work")
			case .share: return ("shareIcon", "Start adding tasks", "Assign, set due dates, and get to work")
			case .workflow: return ("workflowIcon", "Start adding tasks", "Assign, set due dates, and get to work")
		}
	}
}

@Model
class ProjectModel {
    // MARK: Generic variables
    var name: String
    var startDate: Date?
    var endDate: Date?
    var details: String?
    var color: ProjectColor
    var icon: ProjectIcon
    var defaultTab: ProjectTab
    var privacy: PrivacyStatus
    var archived: Bool
    
    // MARK: Inferred relationships
    // These are inferred from setting the relationship on the parent
    // or if the model has just a singular variable
    var owner: MemberModel
    var team: TeamModel?
    var sections: [SectionModel]?
    
    // MARK: Explicit relationships
    @Relationship(deleteRule: .nullify, inverse: \TaskModel.projects)
    var tasks: [TaskModel]
    
    @Relationship(deleteRule: .nullify, inverse: \MemberModel.projects)
    var members: [MemberModel]
    
    @Relationship(deleteRule: .nullify, inverse: \CommentModel.projects)
    var comments: [CommentModel]?

    init(
        name: String,
        startDate: Date? = nil,
        endDate: Date? = nil,
        details: String? = nil,
        owner: MemberModel,
        team: TeamModel? = nil,
        tasks: [TaskModel] = [],
        members: [MemberModel] = [],
        sections: [SectionModel] = [],
        color: ProjectColor = ProjectColor.allCases.randomElement()!,
        icon: ProjectIcon = ProjectIcon.allCases.randomElement()!,
        defaultTab: ProjectTab = .list,
        privacy: PrivacyStatus = PrivacyStatus.publicToTeam,
        archived: Bool = false
    ) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.details = details
        self.owner = owner
        self.team = team
        self.tasks = tasks
        self.members = members
        self.sections = sections
        self.color = color
        self.icon = icon
        self.defaultTab = defaultTab
        self.privacy = privacy
        self.archived = archived
    }
}

