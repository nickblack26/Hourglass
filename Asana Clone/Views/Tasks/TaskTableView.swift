import SwiftUI

struct TaskTableView: View {
	@State private var isExpanded: Bool = false
    @State private var selectedTasks = Set<TaskModel>()
	@State private var sortOrder: [KeyPathComparator<TaskModel>] = [.init(\.name)]
	@SceneStorage("BugReportTableConfig")
	private var columnCustomization: TableColumnCustomization<TaskModel>
	var sections: [SectionModel]
	
	init(_ sections: [SectionModel]) {
		self.sections = sections
	}
	
	var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ControlGroup(content: {
                    Button("Add task", systemImage: "plus") {
                        
                    }
                    .tint(.accent)
                    .buttonStyle(.bordered)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.down")
                    }
                    .tint(.accent)
                    .buttonStyle(.bordered)
                })
                Spacer()
                
            }
            Table(
                of: TaskModel.self,
    //            selection: $selectedTasks,
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
                        start_date: task.startDate,
                        end_date: task.endDate
                    )
                }
            } rows: {
                ForEach(sections) { section in
                    Section {
                        TableRow(TaskModel.preview[0])
                    } header: {
                        Text(section.name)
                    }
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
