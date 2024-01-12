import SwiftUI
import SwiftData

struct TaskListView: View {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var isCompact: Bool { horizontalSizeClass == .compact }
    #else
    private let isCompact = false
    #endif
    @Environment(AsanaManager.self) private var asanaManager
    @Environment(\.modelContext) private var modelContext
    
    
    
//    @State private var selectedPeople = Set<Task.>()
    
    var sections: [aSection]
    
    init(_ sections: [aSection]) {
        self.sections = sections
    }
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        
        Table(of: aTask.self) {
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
                    
                    if let subtasks = task.subtasks, !subtasks.isEmpty {
                        Text("\(subtasks.count) \(Image("subtask_icon"))")
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
                    ForEach(task.projects ?? []) { project in
                        Text(project.name)
                    }
                }
            }
            
            TableColumn(
                """
                    \(
                        Image(systemName: "plus")
                )
                """) { _ in
                    
                }
        } rows: {
            ForEach(sections) { section in
                SwiftUI.Section {
                    ForEach(section.tasks ?? []) { task in
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
    
    private func addTaskToSection(_ section: aSection) {
        let task = aTask(name: "", order: section.tasks?.count ?? 0)
        section.tasks?.insert(task, at: 0)
    }
    
    private mutating func addNewSectionAbove(currentIndex: Int) {
        if currentIndex == 0 {
            let newSection = aSection(name: "", order: 0)
            modelContext.insert(newSection)
            sections.insert(newSection, at: 0)
        } else {
            let newSection = aSection(name: "", order: currentIndex - 1)
            modelContext.insert(newSection)
            sections.insert(newSection, at: currentIndex - 1)
        }
    }
    
    private mutating func addNewSectionBelow(currentIndex: Int) {
        let newSection = aSection(name: "", order: currentIndex + 1)
        modelContext.insert(newSection)
        sections.insert(newSection, at: currentIndex + 1)
    }
}

#Preview {
    @State var asanaManager = AsanaManager()
    let section = aSection(name: "", order: 0)

    return TaskListView(
        [
            section
        ]
    )
    .environment(asanaManager)
    .modelContainer(previewContainer)

}
