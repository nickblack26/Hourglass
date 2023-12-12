import SwiftUI
import SwiftData

struct TaskTableView: View {
    @Query var projects: [ProjectModel]
    @Environment(AsanaManager.self) private var asanaManager
    @Environment(\.modelContext) private var modelContext
    @State private var sortOrder: [KeyPathComparator<TaskModel>] = [.init(\.name)]
    
    var sections: [SectionModel]
    
    init(_ sections: [SectionModel]) {
        self.sections = sections
    }
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        Table(
            of: TaskModel.self,
            sortOrder: $sortOrder
        ) {
            TableColumn("Task name") { task in
                @Bindable var task = task
                HStack {
                    Button {
                        task.isCompleted.toggle()
                    } label: {
                        Image(systemName: "checkmark.circle")
                    }
                    .help("Mark task complete")
                    
                    TextField("Task name", text: $task.name)
                    
                    let subtasks = task.subtasks
                    
                    if subtasks.count > 0 {
                        Text("\(subtasks.count) \(Image("subtask_icon"))")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "arrow.up.arrow.down")
                    
                    Image(systemName: "chevron.right")
                }
                .onTapGesture {
                    asanaManager.selectedTask = task
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
                @FocusState var isFocused: Bool
                @State var searchText: String = ""
                var searchedProjects: [ProjectModel] {
                    if searchText.isEmpty {
                        return projects
                    } else {
                        return projects.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                    }
                }
                
                HStack {
                    if let projects = task.projects {
                        ForEach(projects) { project in
                            Text(project.name)
                        }
                    }
                    
                    TextField(
                        "Add project",
                        text: $searchText,
                        prompt: Text("Add to another project...")
                    )
                    .onSubmit {
                        if !searchedProjects.isEmpty {
                            task.projects?.append(searchedProjects[0])
                        }
                    }
                    .focused($isFocused)
                    .popover(
                        isPresented: Binding(
                            get: { isFocused && !searchedProjects.isEmpty },
                            set: { newValue in
                            }),
                        content: {
                            ForEach(searchedProjects) {
                                Text($0.name)
                            }
                        })
                }
            }
        } rows: {
            ForEach(sections) { section in
                @Bindable var section = section
                @State var isExpanded: Bool = true
                
                Section(isExpanded: $isExpanded) {
                    ForEach(section.tasks) { task in
                        TableRow(task)
                    }
                } header: {
                    HStack {
                        TextField("Section Name", text: $section.name)
                            .textFieldStyle(.roundedBorder)
                            .frame(minWidth: 200)
                        
                        //                        Button("Add task to this section", systemImage: "plus", action: addTaskToSection(section))
                        
                        //                        Menu("More section actions", systemImage: "ellipsis") {
                        //                            Button("Add rule to section", systemImage: "bolt") {
                        //
                        //                            }
                        //
                        //                            Button("Rename section", systemImage: "pencil", action: renameSection.toggle)
                        //
                        //                            Menu("Add section", systemImage: "line.3.horizontal.decrease") {
                        //                                Button("Add section above", systemImage: "arrow.up", action: addNewSectionAbove)
                        //
                        //                                let currentIndex = sections.firstIndex(of: section)
                        //                                Button("Add section below", systemImage: "arrow.down", action: addNewSectionBelow(currentIndex: currentIndex))
                        //                            }
                        //
                        //                            Button("Delete section", systemImage: "trash", role: .destructive) {
                        //
                        //                                if section.tasks.isEmpty {
                        //                                    withAnimation {
                        //                                        modelContext.delete(section)
                        //                                    }
                        //                                } else {
                        //                                    showDeleteModal.toggle()
                        //                                }
                        //                            }
                        //                        }
                    }
                }
            }
        }
    }
    
    private func addTaskToSection(_ section: SectionModel) {
        if let currentMember = asanaManager.currentMember {
            let task = TaskModel(name: "", assignee: currentMember)
            modelContext.insert(task)
            section.tasks.insert(task, at: 0)
        }
    }
    
    private mutating func addNewSectionAbove() {
        let newSection = SectionModel(name: "")
        modelContext.insert(newSection)
        sections.insert(newSection, at: 0)
    }
    
    private mutating func addNewSectionBelow(currentIndex: Int) {
        let newSection = SectionModel(name: "")
        modelContext.insert(newSection)
        sections.insert(newSection, at: currentIndex + 1)
    }
}

#Preview {
    @State var asanaManager = AsanaManager()
    return TaskTableView(
        [
            .preview
        ]
    )
    .environment(asanaManager)
    .modelContainer(for: [TaskModel.self, ProjectModel.self, SectionModel.self])
}
