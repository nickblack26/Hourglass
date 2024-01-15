import SwiftUI
import SwiftData

struct ProjectView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AsanaManager.self) private var asanaManager
    @State private var selectedTab: Project.Tab = .board
    @State private var showProjectSheet: Bool = false
    @Bindable var project: Project
    @Query var sections: [aSection]
    
    init(_ project: Project) {
        self._selectedTab = State(initialValue: project.defaultTab)
        self.project = project
        let projectId = project.persistentModelID
        self._sections = .init(
            filter: #Predicate<aSection> {
                $0.project != nil && $0.project?.persistentModelID == projectId
            },
            sort: \aSection.order
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ProjectHeader(
                selectedTab: $selectedTab,
                project: project
            )
            
            Divider()
            
            HStack {
                Button("Add task", systemImage: "plus") {
                    withAnimation(.snappy) {
                        addNewTask()
                    }
                }
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
                TaskListView(sections)
            case .board:
                TaskBoardView(
                    project: project,
                    sections: sections
                )
            case .timeline:
                EmptyView()
            case .calendar:
                EmptyView()
            case .workflow:
                EmptyView()
            case .dashboard:
                ProjectDashboardView()
                    .padding()
            case .messages:
                EmptyView()
            case .files:
                EmptyView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle($project.name)
        .toolbar {
            ToolbarItem(placement: .secondaryAction) {
                Button("Add to favorites", systemImage: "star") {
                    
                }
            }
        }
        .toolbarRole(.editor)
        .onAppear {
            if sections.isEmpty {
                let section = aSection(name: "", order: 0, project: project)
                modelContext.insert(section)
            }
        }
        .sheet(isPresented: $showProjectSheet, content: {
            SectionForm(project: project)
        })
    }
    
    private func addNewSection() {
        let section = aSection(name: "", order: sections.count, project: project)
        modelContext.insert(section)
    }
    
    private func addNewTask() {
        let task = aTask(name: "", order: sections[0].tasks?.count ?? 0)
        
        if let tasks = project.tasks, tasks.isEmpty {
            sections[0].tasks?.append(task)
        } else {
            sections[0].tasks?.insert(task, at: 0)
        }
    }
}

#Preview {
    @State var asanaManager = AsanaManager()
//    let project = Project(name: "")

    return NavigationStack {
        ProjectView(.init(name: ""))
    }
    .environment(asanaManager)
//    .modelContainer(previewContainer)

}
