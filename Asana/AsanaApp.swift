import SwiftUI
import SwiftData

let fullSchema = Schema([Team.self, Project.self, Task.self, Section.self])

@main
struct Asana_App: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @State var cloudKitManager = CloudKitManager()
    @State var asanaManager = AsanaManager()
    let container: ModelContainer = {
        do {
            
            let config = ModelConfiguration("Asana", cloudKitDatabase: .automatic)
            
            let container = try ModelContainer(for: fullSchema, configurations: config)
            
            var sectionFetchDescriptor = FetchDescriptor<Section>()
            
            guard try container.mainContext.fetchCount(sectionFetchDescriptor) > 0  else { return container }
            
            let recentlyAssignedSection: Section = .init(name: "Recently assigned", order: 0)
            let doTodaySection: Section = .init(name: "Do today", order: 1)
            let doNextWeekSection: Section = .init(name: "Do next week", order: 2)
            let doLaterSection: Section = .init(name: "Do later", order: 3)
            
            return container
        } catch {
            fatalError("Failed to create model container.")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    asanaManager.path.append(.home)
                }
                .sheet(item: $asanaManager.selectedTask) { task in
                    TaskDetailView(task)
                        .environment(asanaManager)
                }
                .sheet(item: $asanaManager.selectedCustomField) { field in
                    CustomFieldModal(field)
                }
                .environment(asanaManager)
                .environment(cloudKitManager)
                .modelContainer(container)
                .toolbar(.hidden)
        }
        .commands {
            SidebarCommands()
            TextEditingCommands()
            TextFormattingCommands()
        }
    }
}

extension ModelContext {
    func existingModel<T>(for objectID: PersistentIdentifier)
    throws -> T? where T: PersistentModel {
        if let registered: T = registeredModel(for: objectID) {
            return registered
        }
        
        let fetchDescriptor = FetchDescriptor<T>(
            predicate: #Predicate {
                $0.persistentModelID == objectID
            })
        
        return try fetch(fetchDescriptor).first
    }
}

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
