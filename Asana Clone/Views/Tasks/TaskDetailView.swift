import SwiftUI
import SwiftData

struct TaskDetailView: View {
    @Bindable var task: TaskModel
    
    init(_ task: TaskModel) {
        self.task = task
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TaskDetailHeader(task)
            
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
                TaskDetailBody(task)
            }
            .scrollIndicators(.hidden)
            
            Divider()
            
            TaskDetailFooter()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

#Preview("Sheet") {
    @State var asanaManager = AsanaManager()
    return VStack {
        Text("Test")
    }
    .environment(asanaManager)
    .sheet(isPresented: .constant(true), content: {
        TaskDetailView(.preview[0])
    })
}

struct TaskDetailHeader: View {
    @Environment(AsanaManager.self) private var asanaManager
    @Bindable var task: TaskModel
    
    init(_ task: TaskModel) {
        self.task = task
    }
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        HStack(spacing: 16) {
            Button(task.isCompleted ? "Completed" : "Mark complete", systemImage: "checkmark") {
                withAnimation(.snappy) {
                    task.isCompleted.toggle()
                }
            }
            .buttonStyle(.bordered)
            .tint(task.isCompleted ? .green : .white)
            .foregroundStyle(task.isCompleted ? .green : .primary)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(task.isCompleted ? .green : .primary, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Spacer()
            
            Image(systemName: "hand.thumbsup")
            
            Image(systemName: "paperclip")
            
            Image("subtask_icon")
                .resizable()
                .frame(width: 18, height: 18)
            
            Image(systemName: "link")
            
            Image(systemName: "arrow.down.left.and.arrow.up.right")
            
            Image(systemName: "ellipsis")
            
            Button {
                asanaManager.selectedTask = nil
            } label: {
                Image(systemName: "xmark")
            }
        }
        .padding()
    }
}

#Preview("Header") {
    @State var asanaManager = AsanaManager()
    return TaskDetailHeader(.preview[0])
        .environment(asanaManager)
}

struct TaskDetailFooter: View {
    @State private var comment: String = ""
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image("profile")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(maxWidth: 48, maxHeight: 48)
            
            VStack(alignment: .leading) {
                TextField("Comment", text: $comment, prompt: Text("Add a comment"), axis: .vertical)
                    .lineLimit(4, reservesSpace: true)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    Text("Collaborators")
                        .foregroundStyle(.secondary)
                    
                    HStack(alignment: .center, spacing: 0) {
                        Image("profile")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(maxWidth: 28, maxHeight: 28)
                            .padding(.trailing, 2)
                        
                        ForEach(0..<2, id: \.self) { _ in
                            Button {} label: {
                                Image(systemName: "person")
                                    .imageScale(.small)
                            }
                            .buttonStyle(.bordered)
                            .tint(.clear)
                            .foregroundStyle(.secondary)
                            .overlay(
                                Circle()
                                    .strokeBorder(
                                        .secondary,
                                        style:
                                            StrokeStyle(
                                                lineWidth: 1,
                                                dash: [4]
                                            )
                                    )
                            )
                            .clipShape(Circle())
                        }
                    }
                    
                    Image(systemName: "plus")
                        .imageScale(.small)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Button("Leave task", systemImage: "bell.fill") {
                        
                    }
                    .tint(.secondary)
                    
                }
                .padding(.top)
            }
        }
        .padding()
        .background(.primary.quinary)
    }
}

#Preview("Footer") {
    TaskDetailFooter()
}

struct TaskDetailBody: View {
    @Query private var allProjects: [ProjectModel]
    @State private var showProjectPicker: Bool = false
    @Bindable var task: TaskModel
    
    init(_ task: TaskModel) {
        self.task = task
    }
    
    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 32) {
                TextField("Task name", text: $task.name)
                    .font(.title)
                    .fontWeight(.semibold)
                
                LabeledContent("Assignee") {
                    HStack {
                        if let assignee = task.assignee {
                            Image("profile")
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(maxWidth: 32, maxHeight: 32)
                            
                            if let assignee = task.assignee {
                                Text(assignee.name)
                            }
                            
                            HStack(spacing: 2) {
                                Text("Nick Black")
                                Image(systemName: "moon.zzz")
                                    .imageScale(.small)
                            }
                            .foregroundStyle(.primary)
                            
                            Image(systemName: "xmark")
                                .imageScale(.small)
                            
                            Menu {
                                Section("My tasks") {
                                    
                                }
                            } label: {
                                Text("📬 New tasks")
                                Image(systemName: "chevron.down")
                                    .imageScale(.small)
                            }
                            .foregroundStyle(.secondary)
                            .padding(.leading, 16)
                        } else {
                            Button {} label: {
                                Image(systemName: "person")
                                    .imageScale(.medium)
                            }
                            .buttonStyle(.bordered)
                            .tint(.white)
                            .overlay(
                                Circle()
                                    .strokeBorder(
                                        .secondary,
                                        style:
                                            StrokeStyle(
                                                lineWidth: 1,
                                                dash: [4]
                                            )
                                    )
                            )
                            .clipShape(Circle())
                            .foregroundStyle(.secondary)
                            
                            if let startDate = task.startDate {
                                if let endDate = task.endDate {
                                    Text("\(startDate.formatted(date: .numeric, time: .omitted)) - \(endDate.formatted(date: .numeric, time: .omitted))")
                                } else {
                                    Text("\(startDate.formatted(date: .numeric, time: .omitted))")
                                }
                            } else {
                                Text("No due date")
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.leading, 64)
                }
                
                LabeledContent("Due date") {
                    HStack {
                        Button {} label: {
                            Image(systemName: "calendar")
                                .imageScale(.medium)
                        }
                        .buttonStyle(.bordered)
                        .tint(.white)
                        .overlay(
                            Circle()
                                .strokeBorder(
                                    .secondary,
                                    style:
                                        StrokeStyle(
                                            lineWidth: 1,
                                            dash: [4]
                                        )
                                )
                        )
                        .clipShape(Circle())
                        .foregroundStyle(.secondary)
                        
                        if let startDate = task.startDate {
                            if let endDate = task.endDate {
                                Text("\(startDate.formatted(date: .numeric, time: .omitted)) - \(endDate.formatted(date: .numeric, time: .omitted))")
                            } else {
                                Text("\(startDate.formatted(date: .numeric, time: .omitted))")
                            }
                        } else {
                            Text("No due date")
                        }
                        
                        Spacer()
                    }
                    .padding(.leading, 64)
                }
                
                LabeledContent("Projects") {
                    HStack {
                        if let projects = task.projects {
                            ForEach(projects) { project in
                                HStack {
                                    HStack(spacing: 4) {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(project.color.color)
                                            .frame(width: 8, height: 8)
                                        
                                        Text(project.name)
                                            .font(.caption)
                                    }
                                    
                                    Menu {
                                        if let sections = project.sections {
                                            ForEach(sections) { section in
                                                Button(section.name) {
                                                    task.section = section
                                                }
                                            }
                                        }
                                        
                                    } label: {
                                        if let sections = project.sections, sections.isEmpty {
                                            Text("Untitled Sections")
                                        } else {
                                            Text(project.sections?[0].name ?? "")
                                        }
                                    }
                                }
                            }
                        }
                        
                        Button("Add to projects") {
                            showProjectPicker.toggle()
                        }
                        .fontWeight(.medium)
                        .popover(isPresented: $showProjectPicker) {
                            VStack {
                                ForEach(allProjects) { project in
                                    Button(project.name) {
                                        task.projects?.append(project)
                                    }
                                }
                            }
                            .padding()
                        }
                        
                        Spacer()
                    }
                    .padding(.leading, 64)
                }
                
                VStack(alignment: .leading) {
                    Text("Description")
                    
                    TextField(
                        "Task description",
                        text: Binding(get: { return task.details ?? "" }, set: { newValue in
                            task.details = newValue
                        }),
                        prompt: Text("What is this task about?"),
                        axis: .vertical
                    )
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(10, reservesSpace: true)
                }
                
                HStack(spacing: 0) {
                    Button("Add subtask", systemImage: "plus") {
                        
                    }
                    .font(.callout)
                    .buttonStyle(.bordered)
                    .tint(.clear)
                    .foregroundStyle(.primary)
                    .overlay(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 8,
                            bottomLeadingRadius: 8,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 0
                        )
                        .stroke(.secondary, lineWidth: 1)
                    )
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 8,
                            topTrailingRadius: 8
                        )
                    )
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.down")
                    }
                    .buttonStyle(.bordered)
                    .tint(.clear)
                    .foregroundStyle(.primary)
                    .overlay(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 8,
                            topTrailingRadius: 8
                        )
                        .stroke(.secondary, lineWidth: 1)
                    )
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 8,
                            topTrailingRadius: 8
                        )
                    )
                }
            }
            .padding()
        } header: {
            HStack {
                Image(systemName: "lock.fill")
                Text("This task is private to you.")
                
                Spacer()
                
                Button("Make public") {
                    
                }
            }
            .tint(.secondary)
            .foregroundStyle(.secondary)
            .padding()
            .background(.primary.quinary)
        } footer: {
            VStack(alignment: .leading, spacing: 24) {
                Menu {
                    Button("All activity") {
                        
                    }
                    
                    Button("Comments") {
                        
                    }
                } label: {
                    Text("All activity")
                    Image(systemName: "chevron.down")
                        .imageScale(.small)
                }
                .foregroundStyle(.secondary)
                
                HStack(alignment: .top) {
                    Image("profile")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(
                            maxWidth: 48,
                            maxHeight: 48
                        )
                    
                    VStack(alignment: .leading) {
                        Text("\(Text("Nick Black").fontWeight(.semibold)) created this task • 4 days ago")
                            .font(.callout)
                            .padding(.bottom)
                        
                        Text("\(Text("Nick Black").fontWeight(.semibold)) assigned to you • 4 days ago")
                            .font(.caption)
                        
                        Text("\(Text("Nick Black").fontWeight(.semibold)) completed this task • 2 hours ago")
                            .font(.caption)
                        
                        Text("\(Text("Nick Black").fontWeight(.semibold)) marked incomplete • 2 hours ago")
                            .font(.caption)
                    }
                    .foregroundStyle(.secondary)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.primary.quinary)
        }
    }
}

#Preview("Body") {
    TaskDetailBody(.preview[0])
}
