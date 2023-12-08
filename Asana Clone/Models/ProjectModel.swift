//
//  ProjectModel.swift
//  Asana Clone
//
//  Created by Nick on 6/24/23.
//

import Foundation
import SwiftData
import SwiftUI

enum ProjectColor: CaseIterable {
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

enum TaskViewChoice: String, CaseIterable, Codable {
	case list = "List"
	case board = "Board"
	case timeline = "Timeline"
	case calendar = "Calendar"
	
	var image: String {
		switch self {
			case .list: return "newProjectList"
			case .board: return "newProjectBoard"
			case .timeline: return "newProjectTimeline"
			case .calendar: return "newProjectCalendar"
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
    var name: String
    var startDate: Date?
    var endDate: Date?
    var details: String?
    var owner: MemberModel
    var team: TeamModel
    var tasks: [TaskModel]
    var members: [MemberModel]
    var sections: [SectionModel]
    
    init(name: String, startDate: Date? = nil, endDate: Date? = nil, details: String? = nil, owner: MemberModel, team: TeamModel, tasks: [TaskModel] = [], members: [MemberModel] = [], sections: [SectionModel] = []) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.details = details
        self.owner = owner
        self.team = team
        self.tasks = tasks
        self.members = members
        self.sections = sections
    }
}

