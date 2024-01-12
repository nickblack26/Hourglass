import SwiftUI

struct TaskBoardView: View {
    @State private var currentlyDraggingTask: aTask?
    @State private var currentlyDraggingSection: aSection?
    var sections: [aSection]
    
    init(_ sections: [aSection]) {
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
//                        sections.append(aSection(name: "", order: sections.count))
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    .padding()
                }
                .frame(width: 375, alignment: .topLeading)
                .frame(maxHeight: .infinity)
                .background(Color(uiColor: .systemGray6).opacity(0.5).gradient)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(.horizontal)
    }
}

#Preview {
    @State var asanaManager = AsanaManager()
    let section = aSection(name: "", order: 0)

    
    return TaskBoardView([section])
        .environment(asanaManager)
        .modelContainer(previewContainer)

}

struct TasksView: View {
    var tasks: [aTask]
    
    init(_ tasks: [aTask]) {
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
    @Bindable var section: aSection
    
    var body: some View {
        ScrollView(.vertical) {
            SwiftUI.Section {
				TasksView(section.tasks ?? [])
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
		.background(section.tasks != nil && section.tasks!.isEmpty ? Color(uiColor: .systemGray6).opacity(0.5) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private func addTaskToSection() {
        if let project = section.project {
			let newTask = aTask(name: "", order: section.tasks?.count ?? 0, projects: [project], section: section)
            section.tasks?.append(newTask)
        } else  {
            let newTask = aTask(name: "", order: section.tasks?.count ?? 0, section: section)
            section.tasks?.append(newTask)
        }
    }
}
