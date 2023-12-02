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
	@Environment(SupabaseManger.self) private var manager
	@State private var project: PublicProjectsModel?
	@State private var selectedTab: ProjectTab = .board
	let project_id: UUID
	
	init(project_id: UUID) {
		let defaultView: ProjectTab = ProjectTab(rawValue: "List") ?? .list
		self._selectedTab = State(initialValue: defaultView)
		self.project_id = project_id
	}
	
	var body: some View {
		VStack(alignment: .leading) {
			//			if let project {
			//				ProjectHeader(selectedTab: $selectedTab, project: project)
			//
			//
			//			} else {
			//				ContentUnavailableView("Loading", systemImage: "")
			//			}
			
			ProjectHeader(selectedTab: $selectedTab, project: project ?? .init(id: UUID(), name: "Test"))
			
			TabView(selection: $selectedTab) {
				ProjectOverviewTab()
					.tag(ProjectTab.overview)
				
				TaskListView()
					.tag(ProjectTab.list)
					.padding()
				
				TaskBoardView(sections: project?.sections ?? [])
					.tag(ProjectTab.board)
					.padding()
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
			
		}
		.task {
			await getProject()
		}
	}
	
	private func getProject() async {
		let query = manager.client.database
			.from("projects")
			.select(columns: "id, name, team: team_id(id, name), sections: sections(id, name, section_tasks: project_tasks(task: task_id(id, name, is_complete)))")
			.eq(column: "id", value: self.project_id)
			.single()
		
		do {
			self.project = try await query.execute().value
		} catch {
			print(error)
		}
	}
	
}

let testManager = SupabaseManger()

#Preview {
	ProjectView(project_id: UUID(uuidString: "5b865a21-84f9-442e-b1ee-5d39845e2e7b") ?? UUID())
		.environment(testManager)
}
