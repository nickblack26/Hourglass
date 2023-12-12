import SwiftUI
import SwiftData

let fullSchema = Schema([TeamModel.self, ProjectModel.self, TaskModel.self, SectionModel.self, MemberModel.self, WidgetModel.self])

@main
struct Asana_CloneApp: App {
	@UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @State var cloudKitManager = CloudKitManager()
    @State var asanaManager = AsanaManager()
    let container: ModelContainer = {
        do {
            let config = ModelConfiguration(cloudKitDatabase: .none)
            let container = try ModelContainer(for: fullSchema, configurations: config)
    
            let myTasksWidget: WidgetModel = .init(name: "My Tasks", image: "myTasksWidgetPreview", type: .myTasks)
            let peopleWidget: WidgetModel = .init(name: "People", image: "peopleWidgetPreview",  columns: 2, type: .people)
            let projectsWidget: WidgetModel = .init(name: "Projects", image: "projectsWidgetPreview", type: .projects)
            let notepadWidget: WidgetModel = .init(name: "Private notepad", image: "notepadWidgetPreview", type: .notepad)
            let tasksAssignedWidget: WidgetModel = .init(name: "Tasks I've assigned", image: "assignedTasksWidgetPreview", type: .tasksAssigned)
            let draftCommentsWidget: WidgetModel = .init(name: "Draft comments", image: "draftedCommentsWidgetPreview", type: .draftComments)
            let formsWidget: WidgetModel = .init(name: "Forms", image: "formsWidgetPreview", type: .forms)
            let myGoalsWidget: WidgetModel = .init(name: "My goals", image: "myGoalsWidgetPreview", type: .myGoals)
            
            let allWidgets: [WidgetModel] = [
                myTasksWidget,
                peopleWidget,
                projectsWidget,
                notepadWidget,
                tasksAssignedWidget,
                draftCommentsWidget,
                formsWidget,
                myGoalsWidget
            ]
            
            for widget in allWidgets {
                container.mainContext.insert(widget)
            }
            
            return container
        } catch {
            fatalError("Failed to create model container.")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(cloudKitManager)
                .environment(asanaManager)
                .modelContainer(container)
                .modelContainer(for: [TeamModel.self, ProjectModel.self, TaskModel.self, SectionModel.self, MemberModel.self, WidgetModel.self])
        }
    }
}
