import SwiftUI
import SwiftData

struct SidebarView: View {
    @Environment(HourglassManager.self) private var hourglass
    
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
	
//	@Query(
//        filter: #Predicate<TimeTrackingEntry> {
//            return $0.durationMinutes != nil && $0.durationMinutes! > 0
//        }
//	)
//    private var timesheets: [TimeTrackingEntry]
    
    @Query(
        filter: #Predicate<Business> { !$0.archived }
    )
    private var businesses: [Business]
    
    @State private var newProject: Bool = false
    @State private var selectedBusiness: Business?
    
    var body: some View {
        @Bindable var hourglass = hourglass
        
        List(selection: $hourglass.selectedLink) {
//			if !timesheets.isEmpty {
//				Section {
//					ForEach(timesheets) { timesheet in
//						CurrentTimesheetView(timesheet: timesheet)
//					}
//				}
//			}
			
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
            
            Section("Insights") {
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
                SidebarSection(label: "Starred") {
                    ForEach(starredProjects) { project in
                        NavigationLink(value: SidebarLink.project(project)) {
                            ProjectListItem(
                                title: project.name,
                                color: project.color.color
                            )
                        }
                        .contextMenu {
                            ProjectListItemContextMenu(project)
                        }
                    }
                }
            }
            
            SidebarSection("Clients") {
                ForEach(clients) { client in
                    NavigationLink(value: SidebarLink.client(client)) {
                        Label(client.name, systemImage: "person.2")
                            .contextMenu(menuItems: {
                                Button("Archive", systemImage: "archivebox") {
                                    withAnimation(.snappy) {
                                        client.archived.toggle()
                                    }
                                }
                            })
                    }
                }
            }
            
            SidebarSection("Projects") {
                ForEach(projects) { project in
                    NavigationLink(value: SidebarLink.project(project)) {
                        ProjectListItem(
                            title: project.name,
                            subtitle: project.client?.name,
                            color: project.color.color
                        )
                    }
                    .contextMenu {
                        ProjectListItemContextMenu(project)
                    }
                }
            }
        }
		.scrollContentBackground(.hidden)
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
                Menu("New", systemImage: "Plus") {
                    Button("New project", systemImage: "folder") {
                        newProject.toggle()
                    }
                    
                    Button("New client", systemImage: "person.2") {
                        hourglass.newClient.toggle()
                    }
                    
                    Button("New task", systemImage: "checkmark.circle") {
                    }
                }
			}
#if os(iOS)
            ToolbarItem(placement: .bottomBar) {
                Button(action: {}, label: {
                    Image("gearshape")
                    Text("Settings")
                })
            }
#endif
        }
        .sheet(isPresented: $newProject) {
            NavigationStack {
                ProjectDetailView()
            }
        }
    }
}


#Preview {
    @Previewable @State var hourglass = HourglassManager()
    
    NavigationSplitView {
        SidebarView()
    } detail: {
        EmptyView()
    }
    .environment(hourglass)
    .modelContainer(
        for: [
            Business.self,
            Client.self,
            Project.self,
            TimeTrackingEntry.self
        ],
        inMemory: true
    )
}
