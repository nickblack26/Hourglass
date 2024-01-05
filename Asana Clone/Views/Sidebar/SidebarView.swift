import SwiftUI
import SwiftData

enum ProjectSortOption: String, CaseIterable {
    case Alphabetical
    case Recent
    case Top
}

enum SidebarLink: Hashable {
    case home
    case myTasks
    case inbox
    case reporting
    case portfolios
    case goals
    case project(Project)
    case team(UUID)
}

struct SidebarView: View {
    @Environment(AsanaManager.self) private var asanaManager
    
    @Query(
        filter: #Predicate<Project> { !$0.starred },
        sort: \Project.name
    )
    private var projects: [Project]
    
    @Query(
        filter: #Predicate<Project> { $0.starred },
        sort: \Project.name
    )
    private var starredProjects: [Project]
    
    @Query(sort: \Team.name) private var teams: [Team]
    @State private var selectedSort: ProjectSortOption = .Recent
    @State private var newDashboard: Bool = false
    @State private var newPortfolio: Bool = false
    @State private var newProject: Bool = false
    @State private var newGoal: Bool = false
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        
        List(selection: $asanaManager.selectedLink) {
            NavigationLink(value: SidebarLink.home) {
                Label("Home", systemImage: "house")
            }
            
            NavigationLink(value: SidebarLink.myTasks) {
                Label("My Tasks", systemImage: "checkmark.circle")
            }
            
            NavigationLink(value: SidebarLink.inbox) {
                Label("Inbox", systemImage: "bell")
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
                                color: project.color.color,
                                privacy: project.privacy
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
                            color: project.color.color,
                            privacy: project.privacy
                        )
                    }
                    .contextMenu {
                        ProjectListItemContextMenu(project)
                    }
                }
            }
            
            DisclosureGroup(isExpanded: .constant(true)) {
                
            } label: {
                HStack {
                    Text("Projects")
                    
                    Menu {
                        SwiftUI.Section("Sort projects and portfolios") {
                            ForEach(ProjectSortOption.allCases, id: \.self) { option in
                                Button {
                                    selectedSort = option
                                } label: {
                                    Label(option.rawValue, systemImage: selectedSort == option ? "checkmark" : "")
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.callout)
                    }
                    
                    Menu {
                        Button {
                            newProject.toggle()
                        } label: {
                            Label("New project", systemImage: "list.bullet.clipboard")
                        }
                        
                        Button {
                            
                        } label: {
                            Label("New portfolio", systemImage: "folder")
                        }
                    } label: {
                        Image(systemName: "plus")
                            .font(.callout)
                    }
                }
            }
            
            DisclosureGroup("Team", isExpanded: .constant(true)) {
                ForEach(teams) { team in
                    NavigationLink(value: SidebarLink.team(UUID())) {
                        Label(team.name, systemImage: "person.2.fill")
                    }
                }
            }
        }
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
        .sheet(isPresented: $newDashboard) {
            NewDashboardModal()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Add chart")
                            .font(.title)
                            .fontWeight(.medium)
                    }
                    ToolbarItem {
                        Button {
                            newDashboard.toggle()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
        }
        .sheet(isPresented: $newPortfolio) {
            NewDashboardModal()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Add chart")
                            .font(.title)
                            .fontWeight(.medium)
                    }
                    ToolbarItem {
                        Button {
                            newPortfolio.toggle()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
        }
        .sheet(isPresented: $newGoal) {
            NewDashboardModal()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Add chart")
                            .font(.title)
                            .fontWeight(.medium)
                    }
                    ToolbarItem {
                        Button {
                            newGoal.toggle()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
        }
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
