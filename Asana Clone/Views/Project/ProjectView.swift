//
//  ProjectView.swift
//  Asana Clone
//
//  Created by Nick on 6/22/23.
//

import SwiftUI

enum ProjectTab: String, CaseIterable {
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
}

struct ProjectView: View {
	@State private var selectedTab: ProjectTab = .board
	let project: ProjectModel
	
	init(_ project: ProjectModel) {
		let defaultView: ProjectTab = ProjectTab(rawValue: "List") ?? .list
		self._selectedTab = State(initialValue: defaultView)
		self.project = project
	}
	
	var body: some View {
		VStack(alignment: .leading) {
            ProjectHeader(selectedTab: $selectedTab, project: project)
			
            ProjectHeader(selectedTab: $selectedTab, project: project)
			
			TabView(selection: $selectedTab) {
				ProjectOverviewTab()
					.tag(ProjectTab.overview)
				
				TaskListView()
					.tag(ProjectTab.list)
					.padding()
				
                TaskBoardView(project.sections)
					.tag(ProjectTab.board)
					.padding()
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
			
		}
	}
}

#Preview {
    ProjectView(.preview)
}
