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
        @Bindable var asanaManager = asanaManager
        VStack(alignment: .leading, spacing: 0) {
            ProjectHeader(selectedTab: $selectedTab, project: project)
            
            Divider()
            
            HStack {
                Button("Add task", systemImage: "plus", action: addNewTask)
                    .tint(.accent)
                    .buttonStyle(.borderedProminent)
                
                Menu("", systemImage: "chevron.down") {
                    Button("Add section") {
                        withAnimation(.snappy) {
                            addNewSection()
                        }
                    }
                    Button("Add milestone...", action: addNewSection)
                    Button("Add custom field") {
                        asanaManager.selectedCustomField = .init()
                    }
                }
                .labelsHidden()
                .buttonStyle(.borderedProminent)
                .tint(.clear)
                .foregroundStyle(.primary)
                
                Spacer()
                
                
            }
            .padding([.horizontal, .top])
            
            switch selectedTab {
            case .overview:
                ProjectOverviewTab()
            case .list:
                TaskListView(
                    project.sections?.sorted(by: {
                        $0.order < $1.order
                    }) ?? []
                )
            case .board:
                TaskBoardView(
                    project.sections?.sorted(by: {
                        $0.order < $1.order
                    }) ?? []
                )
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
            SectionForm(project: project)
        })
    }
    
    private func addNewSection() {
        let section = aSection(name: "", order: project.sections?.count ?? 0)
        
        project.sections?.append(section)
    }
    
    private func addNewTask() {
        let task = aTask(name: "New task", order: project.tasks?.count ?? 0)
        
        if let tasks = project.tasks, tasks.isEmpty {
            project.sections?[0].tasks?.append(task)
        } else {
            project.sections?[0].tasks?.insert(task, at: 0)
        }
    }
}

#Preview {
    @State var asanaManager = AsanaManager()
    let project = Project(name: "")

    
    return ProjectView(project)
        .environment(asanaManager)
        .modelContainer(previewContainer)

}
