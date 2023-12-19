import SwiftUI
import SwiftData

enum MyTaskTab: String, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    
    case list = "List"
    case board = "Board"
    case calendar = "Calendar"
}

struct MyTasksView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AsanaManager.self) private var asanaManager
    @Query var sections: [Section]
    @State private var selectedTab: MyTaskTab? = .list
    @State private var showFilters: Bool = false
    
    init() {
        self._sections = Query(
            filter: #Predicate<Section> { section in
                if let member = section.member {
                    return true
                } else {
                    return false
                }
            },
            sort: \Section.order
        )
    }
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        VStack(alignment: .leading) {
            HStack(spacing: 24) {
                AvatarView(
                    image: tempUrl,
                    fallback: "Nick Black",
                    size: .xlarge
                )
                
                VStack(alignment: .leading) {
                    Text("My tasks")
                        .font(.title)
                        .fontWeight(.medium)
                    
                    HStack(spacing: 16) {
                        ForEach(MyTaskTab.allCases) { tab in
                            Button(tab.rawValue) {
                                selectedTab = tab
                            }
                            .buttonStyle(.plain)
                            .foregroundStyle(tab == selectedTab ? .primary : .secondary)
                        }
                    }
                }
                
                Spacer()
                
                Button("Share", systemImage: "lock.fill") {
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.clear)
                .foregroundStyle(.primary)
                
                Divider()
                    .frame(maxHeight: 36)
                
                Button("Customize", systemImage: "square.grid.2x2") {
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.clear)
                .foregroundStyle(.primary)
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
            
            VStack {
                HStack {
                    Button("Add task", systemImage: "plus", action: addNewTask)
                        .tint(.accent)
                        .buttonStyle(.borderedProminent)
                    
                    Menu("", systemImage: "chevron.down") {
                        Button("Add section") {
                            withAnimation(.snappy) {
                                addNewSection()
                            }
                        }
                        Button("Add milestone...") {
                            withAnimation(.snappy) {
                                addNewSection()
                            }
                        }
                    }
                    .labelsHidden()
                    .buttonStyle(.borderedProminent)
                    .tint(.clear)
                    .foregroundStyle(.primary)
                    
                    Spacer()
                    
                    Button("Filter", systemImage: "line.3.horizontal.decrease") {
                        showFilters.toggle()
                    }
                    .popover(isPresented: $showFilters, content: {
                        FilterBuilderView()
                            .padding()
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(.clear)
                    .foregroundStyle(.primary)
                    
                    Menu("Group by", systemImage: "checklist.unchecked") {
                        Text("None")
                        Text("Due date")
                        Text("Project")
                        Text("Created by")
                        Text("Custom sections")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.clear)
                    .foregroundStyle(.primary)
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Text("None")
                        Text("Due date")
                        Text("Created on")
                        Text("Completed on")
                        Text("Likes")
                        Text("Alphabetical")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.clear)
                    .foregroundStyle(.primary)
                }
                .padding(.horizontal)
                
                switch selectedTab {
                case .list:
                    TaskListView(
						asanaManager.currentMember?.sections?.sorted(by: { $0.order < $1.order }) ?? []
                    )
                case .board:
                    TaskBoardView(
						asanaManager.currentMember?.sections?.sorted(by: { $0.order < $1.order }) ?? []
                    )
                case .calendar:
                    TaskCalendarView()
                case nil:
                    EmptyView()
                }
            }
        }
        .onAppear {
            if sections.isEmpty {
                let section = Section(
                    name: "Untitled section",
                    order: 0,
                    member: asanaManager.currentMember
                )
                modelContext.insert(section)
            }
        }
    }
    
    private func addNewSection() {
        let section = Section(
            name: "",
            order: 0,
            member: asanaManager.currentMember
        )
        if !sections.isEmpty {
            section.order = sections.count + 1
        }
        
        asanaManager.currentMember?.sections?.append(section)
        //        modelContext.insert(section)
    }
    
    private func addNewTask() {
        guard let currentMember = asanaManager.currentMember else { return }
        
		let task = Task(name: "New task", order: sections[0].tasks?.count ?? 0, assignee: currentMember)
		
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
        .modelContainer(for: Section.self, inMemory: true)
}

