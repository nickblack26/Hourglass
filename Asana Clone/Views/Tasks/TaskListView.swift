import SwiftUI
import SwiftData

struct TaskListView: View {
    @Environment(AsanaManager.self) private var asanaManager
    @Environment(\.modelContext) private var modelContext
    
    var sections: [Section]
    
    init(_ sections: [Section]) {
        self.sections = sections
    }
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        Table(of: Task.self) {
            TableColumn("Task name") { task in
                @Bindable var task = task
                HStack {
                    Button {
                        task.isCompleted.toggle()
                        if task.isCompleted {
                            task.completedAt = Date()
                        }
                    } label: {
                        Image(systemName: "checkmark.circle")
                    }
                    .help("Mark task complete")
                    
                    TextField("Task name", text: $task.name)
                    
                    if !task.subtasks.isEmpty {
                        Text("\(task.subtasks.count) \(Image("subtask_icon"))")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "arrow.up.arrow.down")
                    
                    Image(systemName: "chevron.right")
                }
                .onTapGesture {
                    if !task.name.isEmpty {
                        asanaManager.selectedTask = task
                    }
                }
            }
            
            TableColumn("Due date") { task in
                @Bindable var task = task
                TableDateCellView(
                    title: "Due date",
                    start_date: $task.startDate,
                    end_date: $task.endDate
                )
                
            }
            
            TableColumn("Projects") { task in
                @Bindable var task = task
                                
                HStack {
                    ForEach(task.projects) { project in
                        Text(project.name)
                    }
                }
            }
        } rows: {
            ForEach(sections) { section in
                SwiftUI.Section {
                    
                    ForEach(section.tasks) { task in
                        TableRow(task)
                    }
                } header: {
                    HStack {
                        Text(section.name)
                        
                        Menu {
                            SectionActionsContent(
                                viewType: .list,
                                sections: .constant([]),
                                section: section
                            )
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            
        }
    }
    
    private func addTaskToSection(_ section: Section) {
        if let currentMember = asanaManager.currentMember {
            let task = Task(name: "", order: section.tasks.count, assignee: currentMember)
            modelContext.insert(task)
            section.tasks.insert(task, at: 0)
        }
    }
    
    private mutating func addNewSectionAbove(currentIndex: Int) {
        if currentIndex == 0 {
            let newSection = Section(name: "", order: 0)
            modelContext.insert(newSection)
            sections.insert(newSection, at: 0)
        } else {
            let newSection = Section(name: "", order: currentIndex - 1)
            modelContext.insert(newSection)
            sections.insert(newSection, at: currentIndex - 1)
        }
    }
    
    private mutating func addNewSectionBelow(currentIndex: Int) {
        let newSection = Section(name: "", order: currentIndex + 1)
        modelContext.insert(newSection)
        sections.insert(newSection, at: currentIndex + 1)
    }
}

#Preview {
    @State var asanaManager = AsanaManager()
    return TaskListView(
        [
            .preview
        ]
    )
    .environment(asanaManager)
    .modelContainer(for: [Task.self, Project.self, Section.self])
}
