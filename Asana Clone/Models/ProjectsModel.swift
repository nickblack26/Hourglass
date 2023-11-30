//
//  ProjectModel.swift
//  Asana Clone
//
//  Created by Nick on 6/24/23.
//

import Foundation
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

struct PublicProjectsModel: Identifiable, Codable {
	var id: UUID
	var name: String
	var team: PublicTeamsModel?
	var user_id: PublicUsersModel?
	var is_private: Bool?
	var due_date: Date?
	var is_archived: Bool?
	var sections: [PublicProjectSectionModel]?
	var members: [PublicProjectUserModel]?
}

struct PublicProjectUserModel: Codable {
	var project_id: PublicProjectsModel?
	var user_id: PublicUsersModel
	var role: String?
}

struct PublicProjectTaskModel: Codable {
	var project_id: PublicProjectsModel?
	var task: PublicTasksModel
	var section_id: PublicProjectSectionModel?
}

struct PublicProjectSectionModel: Identifiable, Codable {
	var id: UUID
	var name: String
	var project_id: PublicProjectsModel?
	var section_tasks: [PublicProjectTaskModel]? = []
}

struct PublicProjectServerModel: Codable {
	var name: String
	var team_id: UUID?
	var user_id: UUID?
	var due_date: Date?
	var is_archived: Bool?
	var is_private: Bool
	var default_view: String
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
