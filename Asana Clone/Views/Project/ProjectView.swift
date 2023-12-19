import SwiftUI

struct ProjectView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AsanaManager.self) private var asanaManager
    @State private var selectedTab: Project.Tab = .board
    @State private var showProjectSheet: Bool = false
    @Bindable var project: Project
    
    init(_ project: Project) {
        self._selectedTab = State(initialValue: project.defaultTab)
        self.project = project
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ProjectHeader(selectedTab: $selectedTab, project: project)
            
            HStack {
                Button("Add task", systemImage: "plus", action: addNewTask)
                    .tint(.accent)
                    .buttonStyle(.borderedProminent)
                
                Menu("", systemImage: "chevron.down") {
                    Button("Add section") {
                        showProjectSheet.toggle()
                    }
                    Button("Add milestone...", action: addNewSection)
                }
                .labelsHidden()
                .buttonStyle(.borderedProminent)
                .tint(.clear)
                .foregroundStyle(.primary)
                
                Spacer()
                
                
            }
            .padding(.horizontal)
            
            switch selectedTab {
            case .overview:
                ProjectOverviewTab()
            case .list:
					TaskListView(project.sections?.sorted(by: { $0.order < $1.order }) ?? [])
            case .board:
					TaskBoardView(project.sections?.sorted(by: { $0.order < $1.order }) ?? [])
            case .timeline:
                EmptyView()
            case .calendar:
                EmptyView()
            case .workflow:
                EmptyView()
            case .dashboard:
                EmptyView()
            case .messages:
                EmptyView()
            case .files:
                EmptyView()
            }
        }
        .sheet(isPresented: $showProjectSheet, content: {
            NewSectionForm(showProjectSheet: $showProjectSheet, project: project)
        })
    }
    
    private func addNewSection() {
        let section = Section(name: "", order: 0)
		if let sections = project.sections, !sections.isEmpty {
            for index in sections.indices {
                @Bindable var section = sections[index]
                section.order = index + 1
            }
            project.sections?.insert(section, at: 0)
        } else {
            project.sections?.append(section)
        }
    }
    
    private func addNewTask() {
        if let assignee = asanaManager.currentMember {
            let task = Task(name: "New task", order: project.tasks?.count ?? 0, assignee: assignee)
            
			if let tasks = project.tasks, tasks.isEmpty {
				project.sections?[0].tasks?.append(task)
            } else {
				project.sections?[0].tasks?.insert(task, at: 0)
            }
        }
    }
}

#Preview {
    @State var asanaManager = AsanaManager()
    
    return ProjectView(.preview)
        .environment(asanaManager)
}
