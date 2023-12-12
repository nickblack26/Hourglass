import SwiftUI

struct TaskBoardView: View {
    @State private var currentlyDraggingTask: TaskModel?
    @State private var currentlyDraggingSection: SectionModel?
    var sections: [SectionModel]
    
    init(_ sections: [SectionModel]) {
        self.sections = sections
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 2) {
                ForEach(sections) { section in
                    ColumnView(section: section)
                }
                //            if !sections.isEmpty {
                ////                    ForEach(sections, id: \.name) { section in
                ////                        VStack(spacing: 15) {
                ////                            Section {
                ////                                VStack(alignment: .leading) {
                ////                                    ScrollView(.vertical) {
                ////                                        VStack {
                ////                                            if let tasks = section.section_tasks {
                ////                                                ForEach(tasks, id: \.task.id) { task in
                ////                                                    TaskCardView(currentlyDragging: $currentlyDraggingTask, currentlyDraggingSection: $currentlyDraggingSection, task: task.task, section: section)
                ////                                                        .dropDestination(for: TaskModel.self) { items, location in
                ////                                                            currentlyDraggingTask = nil
                ////                                                            currentlyDraggingSection = nil
                ////                                                            return false
                ////                                                        } isTargeted: { status in
                ////                                                            if let currentlyDraggingTask, status, currentlyDraggingTask.id != task.task.id {
                ////                                                                withAnimation(.snappy) {
                ////                                                                    //                                                            replaceItems(items: &tasks, droppingTask: currentlyDragging, section: section, droppingSection: section)
                ////                                                                }
                ////                                                            }
                ////                                                        }
                ////                                                }
                ////                                            }
                ////
                ////                                            HStack {
                ////                                                Spacer()
                ////
                ////                                                Button {
                ////
                ////                                                } label: {
                ////                                                    Label("Add task", systemImage: "plus")
                ////                                                        .font(.caption)
                ////                                                        .foregroundStyle(.secondary)
                ////                                                        .padding()
                ////                                                }
                ////                                                .buttonStyle(.plain)
                ////
                ////                                                Spacer()
                ////                                            }
                ////
                ////                                        }
                ////                                    }
                ////                                }
                ////                                .background {
                ////                                    LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.05), .clear]), startPoint: .top, endPoint: .bottom)
                ////                                }
                ////                                .frame(maxHeight: .infinity, alignment: .top)
                ////                            } header: {
                ////                                HStack {
                ////                                    Text(section.name)
                ////
                ////                                    Spacer()
                ////
                ////                                    Button {
                ////                                        addTask(section)
                ////                                    } label: {
                ////                                        Image(systemName: "plus")
                ////                                    }
                ////
                ////                                    Button {
                ////
                ////                                    } label: {
                ////                                        Image(systemName: "ellipsis")
                ////                                    }
                ////                                }
                ////                            }
                ////                        }
                ////                        .frame(minWidth: 200)
                ////                    }
                //            }
                //
                //
                //            Section {
                //                VStack(alignment: .leading) {
                //                    Spacer()
                //                }
                //                .background {
                //                    LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.05), .clear]), startPoint: .top, endPoint: .bottom)
                //                }
                //                .frame(maxHeight: .infinity, alignment: .top)
                //            } header: {
                //                Button {
                ////                        addSection()
                //                } label: {
                //                    Label("Add section", systemImage: "plus")
                //                }
                //                .buttonStyle(.plain)
                //                .foregroundStyle(.secondary)
                //            }
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    
    
    //	func appendTask(_ section: PublicProjectSectionModel, droppingTask: PublicTasksModel) {
    //		if let currentlyDraggingTask, let currentlyDraggingSection {
    //			if let sectionIndex = currentlyDraggingTask.sections?.firstIndex(where: { $0.id == currentlyDraggingSection.id }) {
    //				var updatedTask = currentlyDraggingTask
    //				updatedTask.sections?.remove(at: sectionIndex)
    //				updatedTask.sections?.insert(section, at: sectionIndex)
    //
    //				var updatedSection = currentlyDraggingSection
    //				//				updatedSection.tasks?.removeAll(where: { $0.id == updatedTask.id })
    //
    //			}
    //		}
    //	}
    
    //	func replaceItems(items: inout [PublicTasksModel], droppingTask: PublicTasksModel, section: PublicProjectSectionModel) {
    //		if let currentlyDraggingTask {
    //			if let sourceIndex = items.firstIndex(where: { $0.id == currentlyDraggingTask.id }),
    //			   let destinationIndex = items.firstIndex(where: { $0.id == droppingTask.id }) {
    //				var sourceItem = items.remove(at: sourceIndex)
    //				items.insert(sourceItem, at: destinationIndex)
    //			}
    //		}
    //	}
}

#Preview {
    TaskBoardView([.preview])
}

struct TasksView: View {
    var tasks: [TaskModel]
    
    init(_ tasks: [TaskModel]) {
        self.tasks = tasks
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(tasks) { task in
                TaskCardView(
                    currentlyDragging: .constant(nil),
                    currentlyDraggingSection: .constant(nil),
                    task: task,
                    section: task.section
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct ColumnView: View {
    @Bindable var section: SectionModel
    
    var body: some View {
        ScrollView(.vertical) {
            Section {
                TasksView(section.tasks)
            } header: {
                HStack {
                    TextField(
                        "Section Name",
                        text: Binding(
                            get: { return section.name },
                            set: { newValue in
                                section.name = newValue
                            }
                        ),
                        prompt: Text("Untitled section")
                    )
                    .font(.title3)
                    .fontWeight(.medium)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .frame(width: 375, alignment: .leading)
        .background(section.tasks.isEmpty ? Color(uiColor: .systemGray6).opacity(0.5) : .clear)
    }
}
