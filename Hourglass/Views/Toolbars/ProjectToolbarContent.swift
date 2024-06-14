import SwiftUI

struct ProjectToolbar: ToolbarContent {
    @State private var sortOrder: [String : KeyPathComparator] = ["Name" : KeyPathComparator(\aTask.name)]
    @State private var openSortEditor: Bool = false
    
    @Environment(HourglassManager.self) private var asana
    @Environment(\.modelContext) private var context
    var project: Project
    
    var body: some ToolbarContent {
        #if os(macOS)
            ToolbarItem {
                Image(project.icon.icon)
                    .resizable()
                    .frame(width: 12, height: 12)
                    .padding(8)
                    .background(project.color.color, in: .rect(cornerRadius: 8))
            }
        #else
            ToolbarItem(placement: .topBarLeading) {
                Image(project.icon.icon)
                    .resizable()
                    .frame(width: 12, height: 12)
                    .padding(8)
                    .background(project.color.color, in: .rect(cornerRadius: 8))
            }
        #endif
        
        ToolbarItemGroup(placement: .secondaryAction) {
            if sortOrder.isEmpty {
                Menu(
                    sortOrder.isEmpty ? "Sort" : "Sort: \(sortOrder.count)",
                    systemImage: "arrow.up.arrow.down"
                ) {
                    Button("Alphabetical", systemImage: "character") {
                        
                    }
                    
//                    Button("Start date", systemImage: "calendar") {
//                        sortOrder.append(["Start date" : KeyPathComparator(\.startDate)])
//                    }
//                    
//                    Button("Due date", systemImage: "calendar") {
//                        sortOrder.append(["Due Date" : KeyPathComparator(\.endDate)])
//                    }
                    
//                    Button("Created on", systemImage: "clock") {
//                        sortOrder.append(["Created on" : KeyPathComparator(\.createdAt)])
//                    }
//                    
//                    Button("Completed on", systemImage: "clock") {
//                        sortOrder.append(["Completed at" : KeyPathComparator(\.completedAt)])
//                    }
                }
            } else {
                Button(
                    sortOrder.isEmpty ? "Sort" : "Sort: \(sortOrder.count)",
                    systemImage: "arrow.up.arrow.down"
                ) {
                    openSortEditor.toggle()
                }
                .popover(isPresented: $openSortEditor,
                         content: {
                    VStack(alignment: .leading, content: {
                        HStack {
                            Text("Sort")
                                .font(.headline)
                            
                            Spacer()
                            
                            Text("clear")
                        }
                        
                        List {
//                            ForEach(SortOrder, id:\.self) { key in
//                                HStack {
//                                    Image(systemName: "rectangle.grid.3x2")
//                                        .imageScale(.small)
//                                        .rotationEffect(.degrees(90))
//                                    
//                                    Text(sortOrder[key])
//                                }
//                            }
//                            .onMove(perform: { indices, newOffset in
//                                sortOrder.move(fromOffsets: indices, toOffset: newOffset)
//                            })
                            
//                            Menu("Add sort", systemImage: "plus") {
//                                Button("Alphabetical", systemImage: "character") {
//                                    sortOrder.append(["Name" : KeyPathComparator(\.name)])
//                                }
//                                
//                                Button("Start date", systemImage: "calendar") {
//                                    sortOrder.append(["Start date" : KeyPathComparator(\.startDate)])
//                                }
//                                
//                                Button("Due date", systemImage: "calendar") {
//                                    sortOrder.append(["Due Date" : KeyPathComparator(\.endDate)])
//                                }
//                                
//                                Button("Created on", systemImage: "clock") {
//                                    sortOrder.append(["Created on" : KeyPathComparator(\.createdAt)])
//                                }
//                                
//                                Button("Completed on", systemImage: "clock") {
//                                    sortOrder.append(["Completed at" : KeyPathComparator(\.completedAt)])
//                                }
//                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    })
                    .frame(
                        minWidth: 250,
                        minHeight: 250,
                        alignment: .leading
                    )
                })
            }
        }
        
        ToolbarItemGroup(placement: .primaryAction) {
            ShareLink(
                project.name,
                item: project,
                preview: .init(
                    project.name,
                    icon: Image(project.icon.icon)
                )
            )
            
            Button("Start timer", systemImage: "clock") {
                withAnimation(.snappy) {
//                    let timesheet = Timesheet(project: project, start: Date())
//                    context.insert(timesheet)
//                    asana.currentTimesheet = timesheet
                }
            }
            
            Button(
                project.starred ? "Unfavorite" : "Favorite",
                systemImage: project.starred ? "star.fill" : "star"
            ) {
                withAnimation(.snappy) {
                    project.starred.toggle()
                }
            }
            
            Menu("Add", systemImage: "plus") {
                Button(
                    "Add task",
                    systemImage: "plus"
                ) {
                    withAnimation(.snappy) {
                        addNewTask()
                    }
                }
                
                Button(
                    "Add section",
                    systemImage: "chart.bar.doc.horizontal"
                ) {
                    withAnimation(.snappy) {
                        addNewSection()
                    }
                }
            }
            
            ProjectActionsMenu(project)
        }
    }
    
    private func addNewSection() {
        withAnimation(.snappy) {
            let section = aSection(name: "", order: project.sections?.count ?? 0, project: project)
            context.insert(section)
        }
    }
    
    private func addNewTask() {
        withAnimation(.snappy) {
            let task = aTask(name: "", order: project.sections?[0].tasks?.count ?? 0)
            project.sections?[0].tasks?.append(task)
        }
    }
}

#Preview {
    NavigationStack {
        VStack {
            
        }
        .toolbar {
            ProjectToolbar(project: .init(name: ""))
        }
        .toolbarRole(.editor)
    }
}
