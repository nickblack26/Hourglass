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
    @Query(sort: \SectionModel.order)
    var sections: [SectionModel]
    @State private var tabProgress: CGFloat = 0
    @State private var selectedTab: MyTaskTab? = .list
    @State private var showFilters: Bool = false
    @State private var showSectionForm: Bool = false
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        VStack(alignment: .leading) {
            HStack {
                Image("profile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 72, height: 72)
                    .cornerRadius(50)
                
                VStack(alignment: .leading) {
                    Text("My tasks")
                        .font(.title)
                        .fontWeight(.medium)
                    
                    HStack(spacing: 0) {
                        ForEach(MyTaskTab.allCases) { tab in
                            Button(tab.rawValue) {
                                withAnimation(.snappy) {
                                    selectedTab = tab
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .background {
                        GeometryReader {
                            let size = $0.size
                            let lineWidth = size.width / CGFloat(MyTaskTab.allCases.count)
                            
                            Capsule()
                                .frame(
                                    width: lineWidth,
                                    height: 2
                                )
                                .frame(
                                    maxHeight: .infinity,
                                    alignment: .bottom
                                )
                                .offset(
                                    x: tabProgress * (size.width - lineWidth)
                                )
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
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 16) {
                        TaskTableView(asanaManager.currentMember?.sections?.sorted(by: { $0.order < $1.order }) ?? [])
                            .containerRelativeFrame(.horizontal)
                        
                        TaskBoardView(asanaManager.currentMember?.sections?.sorted(by: { $0.order < $1.order }) ?? [])
                            .containerRelativeFrame(.horizontal)
                        
                        Text("Hello")
                            .containerRelativeFrame(.horizontal)
                    }
                }
                .scrollPosition(id: $selectedTab)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
            }
        }
        .onAppear {
            if sections.isEmpty {
                let section = SectionModel(
                    name: "Untitled section",
                    order: 0,
                    member: asanaManager.currentMember
                )
                modelContext.insert(section)
            }
        }
    }
    
    private func addNewSection() {
        let section = SectionModel(
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
        if let currentMember = asanaManager.currentMember {
            let task = TaskModel(name: "New task", assignee: currentMember)
            modelContext.insert(task)
            if !sections[0].tasks.isEmpty {
                sections[0].tasks.insert(task, at: 0)
            } else {
                sections[0].tasks.append(task)
            }
        }
    }
}

#Preview {
    MyTasksView()
        .modelContainer(for: SectionModel.self, inMemory: true)
}

