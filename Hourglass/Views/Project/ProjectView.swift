import SwiftUI
import SwiftData
import Contacts

struct ProjectView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(HourglassManager.self) private var hourglass
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
            HStack {
                ForEach(Project.Tab.allCases, id: \.self) { tab in
                    Button(tab.rawValue, systemImage: tab.image) {
                        withAnimation(.snappy) {
                            selectedTab = tab
                        }
                    }
                    .tint(selectedTab == tab ? project.color.color : .secondary)
                }
            }
            .padding(.horizontal)
            .padding(.leading)
            
            Divider()
            
            switch selectedTab {
            case .overview:
                ProjectOverviewTab(project)
            case .list:
                TaskListView(sections)
            case .board:
                TaskBoardView(
                    sections,
                    project: project
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
        .searchable(text: .constant(""))
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
        .navigationTitle($project.name)
        .toolbar { ProjectToolbar(project: project) }
        .toolbarRole(.editor)
        .onAppear {
            if sections.isEmpty {
                let section = aSection(name: "", order: 0, project: project)
                modelContext.insert(section)
            }
        }
    }
}


#Preview {
    @Previewable @State var hourglass = HourglassManager()
    let project = Project(name: "")
    
    return NavigationStack {
        ProjectView(project)
    }
    .environment(hourglass)
    .modelContainer(previewContainer)
    
}
