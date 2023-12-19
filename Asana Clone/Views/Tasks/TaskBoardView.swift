import SwiftUI

struct TaskBoardView: View {
    @State private var currentlyDraggingTask: Task?
    @State private var currentlyDraggingSection: Section?
    var sections: [Section]
    
    init(_ sections: [Section]) {
        self.sections = sections
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(sections) { section in
                    ColumnView(section: section)
                }
                VStack(alignment: .leading) {
                    Button("Add section", systemImage: "plus") {
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding()
                }
                .frame(width: 375, alignment: .topLeading)
                .frame(maxHeight: .infinity)
                .background(Color(uiColor: .systemGray6).opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(.horizontal)
    }
}

#Preview {
    @State var asanaManager = AsanaManager()
    
    return TaskBoardView([.preview])
        .environment(asanaManager)
}

struct TasksView: View {
    var tasks: [Task]
    
    init(_ tasks: [Task]) {
        self.tasks = tasks
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(tasks) { task in
                @Bindable var task = task
                TaskCardView(task)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct ColumnView: View {
    @Environment(AsanaManager.self) var asanaManager
    @Bindable var section: Section
    
    var body: some View {
        ScrollView(.vertical) {
            SwiftUI.Section {
                TasksView(section.tasks)
            } header: {
                HStack {
                    TextField(
                        "Section Name",
                        text: Binding(
                            get: { return section.name },
                            set: { newValue in
                                section.name = newValue
                            }
                        ),
                        prompt: Text("Untitled section")
                    )
                    .font(.title3)
                    .fontWeight(.medium)
                    
                    Button {
                        withAnimation(.snappy) {
                            addTaskToSection()
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.plain)
                    
                    Menu {
                        SectionActionsContent(
                            viewType: .board,
                            sections: .constant([]),
                            section: section
                        )
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .frame(width: 375, alignment: .leading)
        .background(section.tasks.isEmpty ? Color(uiColor: .systemGray6).opacity(0.5) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private func addTaskToSection() {
        if let project = section.project {
            let newTask = Task(name: "", order: section.tasks.count, projects: [project], section: section)
            section.tasks.append(newTask)
        } else if let currentMember = asanaManager.currentMember {
            let newTask = Task(name: "", order: section.tasks.count, section: section, assignee: currentMember)
            section.tasks.append(newTask)
        }
    }
}
