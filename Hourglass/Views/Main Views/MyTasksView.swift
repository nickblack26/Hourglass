import SwiftUI
import SwiftData

enum TaskGroupBy: String, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
    case none = "None"
    case dueDate = "Due Date"
    case project = "Project"
    case createdBy = "Created By"
    case customSections = "Custom Sections"
}

enum TaskSortOption: String, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
    case manual = "Manual"
    case dueDate = "Due Date"
    case creationDate = "Creation Date"
    case priority = "Priority"
    case title = "Title"
}

enum MyTaskTab: String, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
    case list = "List"
    case board = "Board"
    case calendar = "Calendar"
    case files = "Files"
    
    var icon: String {
        switch self {
        case .list:
            "list.dash"
        case .board:
            "rectangle.split.3x1"
        case .calendar:
            "calendar"
        case .files:
            "doc.richtext"
        }
    }
}

struct MyTasksView: View {
    @State private var sort: TaskSortOption = .manual
    @State private var group: TaskGroupBy = .customSections
    @State private var defaultView: MyTaskTab = .list
    
    @Environment(\.modelContext) private var modelContext
    @Environment(HourglassManager.self) private var hourglass
    @Query(
        filter: #Predicate<aSection> {
            $0.project == nil
        },
        sort: \.order,
        animation: .snappy
    )
    var sections: [aSection]
    @State private var selectedTab: MyTaskTab = .list
    @State private var showFilters: Bool = false
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .list:
                TaskListView(sections)
            case .board:
                TaskBoardView(sections)
            case .calendar:
                TaskCalendarView()
            case .files:
                EmptyView()
            }
        }
        .navigationTitle("My tasks")
        .toolbar {
            TaskToolbarContent(
                sort: $sort,
                group: $group,
                defaultView: $defaultView,
                selectedTab: $selectedTab
            )
            
            ToolbarItemGroup(placement: .bottomBar) {
                Menu(
                    "Add",
                    systemImage: "plus"
                ) {
                    Button(
                        "New task",
                        systemImage: "checkmark.circle"
                    ) {
                        withAnimation(.snappy) {
                            addNewTask()
                        }
                    }
                    
                    Button(
                        "New section",
                        systemImage: "chart.bar.doc.horizontal"
                    ) {
                        withAnimation(.snappy) {
                            addNewSection()
                        }
                    }
                }
            }
        }
        .searchable(text: .constant(""))
        .onAppear {
            if sections.isEmpty {
                let recentlyAssignedSection: aSection = .init(name: "Recently assigned", order: 0)
                let doTodaySection: aSection = .init(name: "Do today", order: 1)
                let doNextWeekSection: aSection = .init(name: "Do next week", order: 2)
                let doLaterSection: aSection = .init(name: "Do later", order: 3)
                
                modelContext.insert(recentlyAssignedSection)
                modelContext.insert(doTodaySection)
                modelContext.insert(doNextWeekSection)
                modelContext.insert(doLaterSection)
            }
        }
    }
    
    private func addNewSection() {
        let section = aSection(name: "", order: sections.count)
        
        modelContext.insert(section)
    }
    
    private func addNewTask() {
        let task = aTask(name: "New task", order: sections[0].tasks?.count ?? 0)
        
        let section = sections[0]
        
        if let tasks = section.tasks, tasks.isEmpty {
            sections[0].tasks?.append(task)
        } else {
            sections[0].tasks?.insert(task, at: 0)
        }
    }
}

#Preview {
    MyTasksView()
        .modelContainer(for: aSection.self, inMemory: true)
}

