import SwiftUI
import SwiftData

struct TaskDetailView: View {
    @Bindable var task: aTask
    
    init(_ task: aTask) {
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
            
            TaskDetailFooter(task)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

#Preview("Sheet") {
    @State var asanaManager = HourglassManager()
    let task = aTask(name: "", order: 0)

    return VStack {
        Text("Test")
    }
    .environment(asanaManager)
    .sheet(isPresented: .constant(true), content: {
        TaskDetailView(task)
    })
    .modelContainer(previewContainer)

}

struct TaskDetailHeader: View {
    @Environment(HourglassManager.self) private var asanaManager
    @Bindable var task: aTask
    
    init(_ task: aTask) {
        self.task = task
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Button(task.isCompleted ? "Completed" : "Mark complete", systemImage: "checkmark") {
                withAnimation(.snappy) {
                    task.isCompleted.toggle()
                    if task.isCompleted {
                        task.completedAt = Date()
                    }
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
    @State var asanaManager = HourglassManager()
    let task = aTask(name: "", order: 0)

    return TaskDetailHeader(task)
        .environment(asanaManager)
        .modelContainer(previewContainer)

}

struct TaskDetailFooter: View {
    @Environment(HourglassManager.self) private var asanaManager
    @Environment(\.modelContext) private var context
    @State private var message: String = ""
    @Bindable var task: aTask
    
    init(_ task: aTask) {
        self.task = task
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AvatarView(
                image: tempUrl,
                fallback: "Nick Black",
                size: .medium
            )
            
            VStack(alignment: .leading) {
                TextField("Comment", text: $message, prompt: Text("Add a comment"), axis: .vertical)
                    .lineLimit(4, reservesSpace: true)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        let comment = Comment(message: message, status: .Sent)
                        task.comments?.append(comment)
                    }
                
                HStack {
                    Text("Collaborators")
                        .foregroundStyle(.secondary)
                    
                    HStack(alignment: .center, spacing: 0) {
                        AvatarView(
                            image: tempUrl,
                            fallback: "Nick Black",
                            size: .small
                        )
                        
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
    let task = aTask(name: "", order: 0)

   return TaskDetailFooter(task)
        .modelContainer(previewContainer)

}

struct TaskDetailBody: View {
    @Query private var allProjects: [Project]
    @State private var showProjectPicker: Bool = false
    @State private var showMemberPicker: Bool = false
    @State private var showDatePicker: Bool = false
    @Bindable var task: aTask

    init(_ task: aTask) {
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
//                        ZStack {
//                            if let assignee = task.assignee {
//                                HStack {
//                                    Button {
//                                        showMemberPicker.toggle()
//                                    } label: {
//                                        AvatarView(
//                                            image: tempUrl,
//                                            fallback: "Nick Black",
//                                            size: .small
//                                        )
//                                        
//                                        Text(assignee.name.isEmpty ? "Name" : assignee.name)
//                                    }
//                                    .buttonStyle(.bordered)
//                                    .tint(.clear)
//                                    .foregroundStyle(.primary)
//                                    
//                                    Button {
//                                        withAnimation(.snappy) {
//                                            task.assignee = nil
//                                        }
//                                    } label: {
//                                        Image(systemName: "xmark")
//                                            .imageScale(.small)
//                                    }
//                                    
//                                    if let sections = assignee.sections, !sections.isEmpty {
//                                        Menu {
//                                            SwiftUI.Section("My tasks") {
//                                                
//                                            }
//                                        } label: {
//                                            Text(sections[0].name)
//                                            Image(systemName: "chevron.down")
//                                                .imageScale(.small)
//                                        }
//                                        .foregroundStyle(.secondary)
//                                    }
//                                }
//                            } else {
//                                Button {
//                                    showMemberPicker.toggle()
//                                } label: {
//                                    Image(systemName: "person")
//                                }
//                                .buttonStyle(.bordered)
//                                .tint(.white)
//                                .overlay(
//                                    Circle()
//                                        .strokeBorder(
//                                            .secondary,
//                                            style:
//                                                StrokeStyle(
//                                                    lineWidth: 1,
//                                                    dash: [4]
//                                                )
//                                        )
//                                )
//                                .clipShape(Circle())
//                                .foregroundStyle(.secondary)
//                            }
//                        }
//                        .popover(isPresented: $showMemberPicker) {
////                            MemberPicker($task.assignee)
//                        }
                        
                        Spacer()
                    }
                    .padding(.leading, 64)
                }
                
                LabeledContent("Due date") {
                    HStack {
                        ZStack {
                            if let endDate = task.endDate {
                                Button(getRelativeDate(endDate)) {
                                    showDatePicker.toggle()
                                }
                                .buttonStyle(.bordered)
                                .tint(.white)
                                .foregroundStyle(.secondary)
                            } else {
                                HStack {
                                    Button {
                                        showDatePicker.toggle()
                                    } label: {
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
                                    
                                    Button {
                                        withAnimation(.snappy) {
//                                            task.assignee = nil
                                        }
                                    } label: {
                                        Image(systemName: "xmark")
                                            .imageScale(.small)
                                    }
                                }
                            }
                        }
                        .popover(isPresented: $showDatePicker, content: {
                            DatePickerPopover(date: $task.endDate)
                        })
                        
                        Spacer()
                    }
                    .padding(.leading, 64)
                }
                
                LabeledContent("Projects") {
                    HStack {
						ForEach(task.projects ?? []) { project in
                            HStack {
                                HStack(spacing: 4) {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(project.color.color)
                                        .frame(width: 8, height: 8)
                                    
                                    Text(project.name)
                                        .font(.caption)
                                }
                                
                                Menu {
									ForEach(project.sections ?? []) { section in
                                        Button(section.name) {
                                            task.section = section
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
                
                if let subtasks = task.subtasks, !subtasks.isEmpty {
                    VStack {
                        ForEach(subtasks) { subtask in
                            TaskRowItem(subtask)
                        }
                    }
                }
                
                Button("Add subtask", systemImage: "plus") {
                    withAnimation(.snappy) {
						task.subtasks?.append(aTask(name: "", order: task.subtasks?.count ?? 0))
                    }
                }
                .font(.callout)
                .buttonStyle(.bordered)
                .tint(.clear)
                .foregroundStyle(.primary)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                    .stroke(.secondary, lineWidth: 1)
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 8)
                )
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
                    AvatarView(
                        image: tempUrl,
                        fallback: "Nick Black",
                        size: .medium
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
                
               
//				let filteredComments = task.comments?.filter{$0.status == .Sent}
//				ForEach(filteredComments?.sorted(by: { $0.sentAt! < $1.sentAt! }) ?? []) { comment in
//                    HStack {
//                        AvatarView(
//                            image: tempUrl,
//                            fallback: "Nick Black",
//                            size: .medium
//                        )
//                        
//                        VStack(alignment: .leading) {
//                            if let sender = comment.sender {
//                                Text("\(Text(sender.name).fontWeight(.semibold)) • \(comment.sentAt?.formatted(date: .numeric, time: .omitted) ?? "")")
//                                    .font(.callout)
//                                    .padding(.bottom)
//                            }
//                           
//                            Text(comment.message)
//                                .font(.caption)
//                        }
//                        .foregroundStyle(.secondary)
//                    }
//                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.primary.quinary)
        }
    }
    
    private func getRelativeDate(_ date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        // get exampleDate relative to the current date
        let relativeDate = formatter.localizedString(for: date, relativeTo: Date.now)
        return relativeDate
    }
    
}

#Preview("Body") {
    let task = aTask(name: "", order: 0)

   return TaskDetailBody(task)
        .modelContainer(previewContainer)

}
