import SwiftUI
import SwiftData


struct SidebarView: View {
    @Environment(HourglassManager.self) private var asanaManager
    
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
    
    @Query(
        filter: #Predicate<Client> { !$0.archived },
        sort: \Client.name
    )
    private var clients: [Client]
    
    @State private var newProject: Bool = false
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        
        List(selection: $asanaManager.selectedLink) {
            Section {
                NavigationLink(value: SidebarLink.home) {
                    Label("Home", systemImage: "house")
                }
                
                NavigationLink(value: SidebarLink.myTasks) {
                    Label("My Tasks", systemImage: "checkmark.circle")
                }
                
                NavigationLink(value: SidebarLink.inbox) {
                    Label("Inbox", systemImage: "bell")
                }
                
                NavigationLink(value: SidebarLink.transactions) {
                    Label("Transactions", systemImage: "chart.bar")
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
            } action: {
                
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
                } action: {
                    
                }

            }
            
            SidebarSectionItem(label: "Clients") {
                ForEach(clients) { client in
                    NavigationLink(value: SidebarLink.client(client)) {
                        Label(client.name, systemImage: "person.2")
                    }
                }
            } action: {
                Button("New client", systemImage: "person.2") {
                    asanaManager.newClient.toggle()
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
            } action: {
                Button("New project", systemImage: "clipboard") {
                    newProject.toggle()
                }
            }
        }
        .fullScreenCover(isPresented: $newProject) {
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
        }
    }
}


#Preview {
    @State var asanaManager = HourglassManager()
    
    return NavigationSplitView {
        SidebarView()
    } detail: {
        EmptyView()
    }
    .environment(asanaManager)
    .modelContainer(for: Project.self, inMemory: true)
}
