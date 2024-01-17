import SwiftUI
import SwiftData

let fullSchema = Schema(
    [
        aSection.self,
        aTask.self,
        aChart.self,
        Client.self,
        Comment.self,
        Contact.self,
        CustomField.self,
        Dashboard.self,
        Goal.self,
        Invoice.self,
        Merchant.self,
        Project.self,
        StatusSection.self,
        StatusUpdate.self,
        Timesheet.self,
        Transaction.self
    ]
)

@main
struct Hourglass_App: App {
    @State var cloudKitManager = CloudKitManager()
    @State var asana = HourglassManager()
    let container: ModelContainer = {
        do {
            let config = ModelConfiguration("Asana", cloudKitDatabase: .none)
            
            let container = try ModelContainer(for: fullSchema, configurations: config)
            
            return container
        } catch {
            fatalError("Failed to create model container.")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    asana.path.append(.home)
                }
                .sheet(item: $asana.selectedTask) { task in
                    TaskDetailView(task)
                        .environment(asana)
                }
                .sheet(isPresented: $asana.newClient, content: {
                    ClientSheetContent()
                })
                .sheet(item: $asana.selectedCustomField) { field in
                    CustomFieldModal(field)
                        .environment(asana)
                }
                .sheet(item: $asana.selectedDashboard) { dashboard in
                    NavigationStack {
                        NewDashboardModal(dashboard: dashboard)
                    }
                    .environment(asana)
                }
                .sheet(item: $asana.selectedChart) { chart in
                    NavigationStack {
                        
                    }
                    .environment(asana)
                }
                .environment(asana)
                .environment(cloudKitManager)
                .modelContainer(container)
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
