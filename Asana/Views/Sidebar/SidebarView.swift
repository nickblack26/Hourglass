import SwiftUI
import SwiftData


struct SidebarView: View {
    @Environment(AsanaManager.self) private var asanaManager
    
    @Query(
        filter: #Predicate<Project> { !$0.archived && !$0.starred },
        sort: \Project.name
    )
    private var projects: [Project]
    
    @Query(
        filter: #Predicate<Project> { $0.starred && !$0.archived },
        sort: \Project.name
    )
    private var starredProjects: [Project]
    
    @State private var newProject: Bool = false
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        
        List(selection: $asanaManager.selectedLink) {
            SwiftUI.Section {
                NavigationLink(value: SidebarLink.home) {
                    Label("Home", systemImage: "house")
                }
                
                NavigationLink(value: SidebarLink.myTasks) {
                    Label("My Tasks", systemImage: "checkmark.circle")
                }
                
                NavigationLink(value: SidebarLink.inbox) {
                    Label("Inbox", systemImage: "bell")
                }
            }
               
            SidebarSectionItem(label: "Insights") {
                NavigationLink(value: SidebarLink.reporting) {
                    Label("Reporting", systemImage: "chart.xyaxis.line")
                }
                
                NavigationLink(value: SidebarLink.portfolios) {
                    Label("Portfolios", systemImage: "folder")
                }
                
                NavigationLink(value: SidebarLink.goals) {
                    Label("Goals", systemImage: "mountain.2")
                }
            }
            
            if !starredProjects.isEmpty {
                SidebarSectionItem(label: "Starred") {
                    ForEach(starredProjects) { project in
                        NavigationLink(value: SidebarLink.project(project)) {
                            ProjectListItem(
                                name: project.name,
                                color: project.color.color
                            )
                        }
                        .contextMenu {
                            ProjectListItemContextMenu(project)
                        }
                    }
                }
            }
            
            SidebarSectionItem(label: "Projects") {
                ForEach(projects) { project in
                    NavigationLink(value: SidebarLink.project(project)) {
                        ProjectListItem(
                            name: project.name,
                            color: project.color.color
                        )
                    }
                    .contextMenu {
                        ProjectListItemContextMenu(project)
                    }
                }
            }
        }
        .toolbar(removing: .sidebarToggle)
        .fullScreenCover(isPresented: $newProject, content: {
            NavigationStack {
                NewProjectView(isPresented: $newProject)
                    .toolbar {
                        ToolbarItem {
                            Button {
                                newProject.toggle()
                            } label: {
                                Label("Close", systemImage: "xmark")
                            }
                        }
                    }
            }
        })
        .navigationSplitViewColumnWidth(min: 240, ideal: 300, max: 400)
    }
}


#Preview {
    @State var asanaManager = AsanaManager()
    
    return NavigationSplitView {
        SidebarView()
    } detail: {
        EmptyView()
    }
    .environment(asanaManager)
    .modelContainer(for: Project.self, inMemory: true)
}
