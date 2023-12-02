import SwiftUI

struct TaskTableView: View {
	@State private var isExpanded: Bool = false
	@State private var selectedTasks = Set<PublicTasksModel.ID>()
	@State private var sortOrder: [KeyPathComparator<PublicTasksModel>] = [.init(\.name)]
	@SceneStorage("BugReportTableConfig")
	private var columnCustomization: TableColumnCustomization<PublicTasksModel>
	var sections: [SectionModel]
	
	init(_ sections: [SectionModel]) {
		self.sections = sections
	}
	
	var body: some View {
		Table(
			of: PublicTasksModel.self,
			selection: $selectedTasks,
			sortOrder: $sortOrder,
			columnCustomization: $columnCustomization
		) {
			TableColumn("Task name") { task in
				HStack {
					Button {
						
					} label: {
						Image(systemName: "checkmark.circle")
					}
					
					Text(task.name)
					
					if let subtasks = task.subtasks, subtasks.count > 0 {
						Text("\(subtasks.count) \(Image("subtask_icon"))")
							.font(.caption)
							.foregroundStyle(.secondary)
					}
				}
			}
			
			TableColumn("Due date") { task in
				TableDateCellView(
					title: "Due date",
					start_date: task.start_date,
					end_date: task.end_date
				)
			}
		} rows: {
			ForEach(sections) { section in
				Section {
					ForEach(section.tasks, id: \.self) {
						TableRow($0.task)
					}
				} header: {
					Text(section.name)
				}
			}
		}
	}
}

#Preview {
	TaskTableView(
		[
			.preview,
			.preview,
			.preview,
			.preview,
			.preview
		]
	)
}
