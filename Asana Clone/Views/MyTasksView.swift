//
//  MyTasksView.swift
//  Asana Clone
//
//  Created by Nick on 6/22/23.
//

import SwiftUI

let testTasks: [PublicTasksModel] = [
		.init(id: UUID(), name: "Draft project brief", is_complete: false),
		.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false),
		.init(id: UUID(), name: "Share timeline with teammates", is_complete: false, subtasks: [
		.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false),
		.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false),
		.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false),
		.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false)
	]),
]

enum MyTaskTab: String, CaseIterable, Identifiable {
	var id: Self {
		return self
	}
	
	case list = "List"
	case board = "Board"
	case calendar = "Calendar"
}

struct MyTasksView: View {
	@Environment(SupabaseManger.self) private var supabase
	@State private var tasks: [PublicTasksModel] = []
	@State private var sections: [SectionModel] = []
	@State private var vm = MyTasksViewModel()
	@State private var view: MyTaskTab = .list
	@State private var selectedTasks = Set<PublicTasksModel.ID>()
	@State private var sortOrder = [KeyPathComparator(\PublicTasksModel.name)]
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Image("profile")
					.resizable()
					.scaledToFill()
					.frame(width: 50, height: 50)
					.cornerRadius(50)
				
				VStack(alignment: .leading) {
					Text("My Tasks")
						.font(.title2)
						.fontWeight(.bold)
					
					Picker("", selection: $view) {
						ForEach(MyTaskTab.allCases) { view in
							Text(view.rawValue)
								.tag(view)
						}
					}
					.pickerStyle(.segmented)
				}
			}
			.padding(.horizontal)
			.padding(.top)
			
			Divider()
			
			TaskTableView([])
			
		}
//		.task {
//			let query = supabase.client.database
//				.from("sections")
//				.select(columns: """
//					id,
//					name,
//					project: project_id(id, name),
//					user: user_id(id, name),
//					section_tasks: section_tasks(id, name)
//					is_default,
//					order
//				""")
//			
//			do {
//				self.sections = try await supabase.makeRequest(
//					[SectionModel.self],
//					query: query
//				)
//				print(sections)
//			} catch {
//				print(error.localizedDescription)
//			}
//		}
//		.toolbar {
//			EditButton()
//		}
	}
}

#Preview {
	@Environment(SupabaseManger.self) var supabase
	return NavigationStack {
		MyTasksView()
			.environment(supabase)
	}
}
