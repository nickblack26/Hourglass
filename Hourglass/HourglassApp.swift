import SwiftUI
import SwiftData

let fullSchema = Schema(
    [
        aSection.self,
        aTask.self,
        Client.self,
        Comment.self,
        CustomField.self,
        Dashboard.self,
        Goal.self,
        Invoice.self,
        Merchant.self,
        Project.self,
        StatusSection.self,
        StatusUpdate.self,
        Transaction.self
    ]
)

@main
struct Hourglass_App: App {
    @State var hourglass = HourglassManager()
    
    var body: some Scene {
        #if os(macOS)
        MenuBarExtra("Utility App", systemImage: "hammer") {
            ScrollView {
                
            }
        }
        .menuBarExtraStyle(.window)
        #endif
        
        WindowGroup {
            ContentView()
                .toolbar(removing: .title)
                .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
                .containerBackground(.thickMaterial, for: .window)
                .onAppear {
                    hourglass.path.append(.home)
                }
                .sheet(item: $hourglass.selectedInvoice, content: { invoice in
                    Form {
                        
                    }
                })
                .sheet(item: $hourglass.selectedTask) { task in
                    NavigationStack {
                        TaskDetailView(task)
                    }
                    .environment(hourglass)
                }
                .sheet(isPresented: $hourglass.newClient, content: {
                    ClientSheetContent()
                })
                .sheet(item: $hourglass.selectedCustomField) { field in
                    CustomFieldModal(field)
                        .environment(hourglass)
                }
                .sheet(item: $hourglass.selectedDashboard) { dashboard in
                    NavigationStack {
                        NewDashboardModal(dashboard: dashboard)
                    }
                    .environment(hourglass)
                }
                .environment(hourglass)
                .modelContainer(for: [
                    aSection.self,
                    aTask.self,
                    Attachment.self,
                    Business.self,
                    Client.self,
                    Comment.self,
                    CustomField.self,
                    Dashboard.self,
                    Goal.self,
                    Invoice.self,
                    LineItem.self,
                    Merchant.self,
                    Portfolio.self,
                    Project.self,
                    Service.self,
                    StatusSection.self,
                    StatusUpdate.self,
                    Story.self,
                    Tag.self,
                    TaskTemplate.self,
                    Team.self,
                    TimePeriod.self,
                    Transaction.self,
                    User.self,
                    Workspace.self
                ])
        }
    }
}

let myTasksWidget: Widget = .init(name: "My Tasks", image: "myTasksWidgetPreview", type: .myTasks)
let peopleWidget: Widget = .init(name: "People", image: "peopleWidgetPreview",  columns: 2, type: .people)
let projectsWidget: Widget = .init(name: "Projects", image: "projectsWidgetPreview", columns: 2, type: .projects)
let notepadWidget: Widget = .init(name: "Private notepad", image: "notepadWidgetPreview", type: .notepad)
let tasksAssignedWidget: Widget = .init(name: "Tasks I've assigned", image: "assignedTasksWidgetPreview", type: .tasksAssigned)
let draftCommentsWidget: Widget = .init(name: "Draft comments", image: "draftedCommentsWidgetPreview", type: .draftComments)
let formsWidget: Widget = .init(name: "Forms", image: "formsWidgetPreview", type: .forms)
let myGoalsWidget: Widget = .init(name: "My goals", image: "myGoalsWidgetPreview", type: .myGoals)

let allWidgets: [Widget] = [
    myTasksWidget,
    projectsWidget,
    notepadWidget,
    peopleWidget,
    tasksAssignedWidget,
    draftCommentsWidget,
    formsWidget,
    myGoalsWidget
]
