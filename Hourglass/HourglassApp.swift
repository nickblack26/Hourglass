import SwiftUI
import SwiftData
import CoreData

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
	let storeURL = URL.documentsDirectory.appending(path: "shared.store")
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var cloudKitManager = CloudKitManager()
    @State var hourglass = HourglassManager()
    let container: ModelContainer
	
	init() {
		let config = ModelConfiguration(url: storeURL, cloudKitDatabase: .none)
		var contain: ModelContainer? = nil
		do {
			contain = try ModelContainer(for: fullSchema, configurations: config)
		} catch {
			print("couldn't create ModelContainer()")
		}
		self.container = contain!
	}
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    hourglass.path.append(.home)
                }
				.sheet(item: $hourglass.selectedInvoice, content: { invoice in
					Form {
						
					}
				})
                .sheet(item: $hourglass.selectedTask) { task in
                    TaskDetailView(task)
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
                .sheet(item: $hourglass.selectedChart) { chart in
                    NavigationStack {
                        
                    }
                    .environment(hourglass)
                }
                .environment(hourglass)
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
