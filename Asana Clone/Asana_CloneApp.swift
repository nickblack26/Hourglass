import SwiftUI
import SwiftData

let fullSchema = Schema([Team.self, Project.self, Task.self, Section.self, Member.self, Widget.self])

@main
struct Asana_CloneApp: App {
	@UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @State var cloudKitManager = CloudKitManager()
    @State var asanaManager = AsanaManager()
    let container: ModelContainer = {
        do {
            
			let config = ModelConfiguration(cloudKitDatabase: .automatic)
            let container = try ModelContainer(for: fullSchema, configurations: config)
                        
            var itemFetchDescriptor = FetchDescriptor<Widget>()
            itemFetchDescriptor.fetchLimit = 1
            
            guard try container.mainContext.fetch(itemFetchDescriptor).count == 0 else { return container }
    
            let myTasksWidget: Widget = .init(name: "My Tasks", image: "myTasksWidgetPreview", type: .myTasks)
            let peopleWidget: Widget = .init(name: "People", image: "peopleWidgetPreview",  columns: 2, type: .people)
            let projectsWidget: Widget = .init(name: "Projects", image: "projectsWidgetPreview", type: .projects)
            let notepadWidget: Widget = .init(name: "Private notepad", image: "notepadWidgetPreview", type: .notepad)
            let tasksAssignedWidget: Widget = .init(name: "Tasks I've assigned", image: "assignedTasksWidgetPreview", type: .tasksAssigned)
            let draftCommentsWidget: Widget = .init(name: "Draft comments", image: "draftedCommentsWidgetPreview", type: .draftComments)
            let formsWidget: Widget = .init(name: "Forms", image: "formsWidgetPreview", type: .forms)
            let myGoalsWidget: Widget = .init(name: "My goals", image: "myGoalsWidgetPreview", type: .myGoals)
            
            let allWidgets: [Widget] = [
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
            VStack(spacing: 0) {
                NavigationMenu()
                
                Divider()
                
                ContentView()
            }
            .environment(asanaManager)
            .environment(cloudKitManager)
            .modelContainer(container)
        }
        .commands {
            SidebarCommands()
            TextEditingCommands()
            TextFormattingCommands()
        }
    }
}
