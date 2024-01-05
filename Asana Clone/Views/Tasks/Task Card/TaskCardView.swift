import SwiftUI

struct TaskCardView: View {
    @Environment(AsanaManager.self) private var asanaManager
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) private var colorScheme
    @State private var showSubtasks: Bool = false
    @State private var isHovering: Bool = false
    @State private var showDatePicker: Bool = false
    @State private var showMemberPicker: Bool = false
    @Bindable var task: Task
    @State private var dates: Set<DateComponents> = Set<DateComponents>() {
        didSet {
            let dateArray = Array(dates)
            if dateArray.count > 1 {
                task.startDate = dateArray.first?.date
                task.endDate = dateArray.last?.date
            } else {
                task.endDate = dateArray.first?.date
            }
        }
    }
    
    init(_ task: Task) {
        self.task = task
        var dateArray: [DateComponents] = []
        if let startDate = task.startDate {
            dateArray.append(Calendar.current.dateComponents(
                in: TimeZone.current,
                from: startDate
            ))
        }
        if let endDate = task.endDate {
            dateArray.append(Calendar.current.dateComponents(
                in: TimeZone.current,
                from: endDate
            ))
        }
        _dates = State(initialValue: Set(dateArray))
    }
    
    let columns = Array(repeating: GridItem(), count: 5)
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        VStack(alignment: .leading, spacing: 16) {
			if let projects = task.projects, !projects.isEmpty {
                ProjectPills(projects)
            }
            
            HStack(alignment: .top) {
                Button {
                    withAnimation(.snappy) {
                        task.isCompleted.toggle()
                        if task.isCompleted {
                            task.completedAt = Date()
                        }
                    }
                } label: {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                        .foregroundStyle(task.isCompleted ? .green : .secondary)
                }
                
                TextField("Task name", text: $task.name, axis: .vertical)
            }
            .font(.headline)
            
            HStack {
                ZStack {
                    if let _ = task.assignee {
                        Button {
                            showMemberPicker.toggle()
                        } label: {
                            AvatarView(
                                image: tempUrl,
                                fallback: "Nick Black",
                                size: .small
                            )
                        }
                    } else {
                        Button {
                            showMemberPicker.toggle()
                        } label: {
                            Image(systemName: "person")
                                .imageScale(.medium)
                        }
                        .buttonStyle(.bordered)
                        .tint(.white)
                        .overlay {
                            Circle()
                                .strokeBorder(
                                    .secondary,
                                    style:
                                        StrokeStyle(
                                            lineWidth: 1,
                                            dash: [4]
                                        )
                                )
                        }
                        .clipShape(Circle())
                        .foregroundStyle(.secondary)
                    }
                }
                .popover(isPresented: $showMemberPicker, content: {
                    MemberPicker($task.assignee)
                })
                
                ZStack {
                    if let _ = task.endDate {
                        Button {
                            showDatePicker.toggle()
                        } label: {
                            if let startDate = task.startDate {
                                Text("\(Text(startDate, format: Date.FormatStyle().day().month())) - ")
                            }
                            
                            if let endDate = task.endDate {
                                Text(endDate, format: Date.FormatStyle().day().month())
                            }
                        }
                        .buttonStyle(.bordered)
                        .tint(.white)
                        .foregroundStyle(.secondary)
                    } else {
                        Button {
                            showDatePicker.toggle()
                        } label: {
                            Image(systemName: "calendar")
                                .imageScale(.medium)
                        }
                        .buttonStyle(.bordered)
                        .tint(.white)
                        .overlay {
                            Circle()
                                .strokeBorder(
                                    .secondary,
                                    style:
                                        StrokeStyle(
                                            lineWidth: 1,
                                            dash: [4]
                                        )
                                )
                        }
                        .clipShape(Circle())
                        .foregroundStyle(.secondary)
                    }
                }
                .popover(isPresented: $showDatePicker) {
                    MultiDatePicker(
                        "Date picker",
                        selection: Binding(
                            get: {
                                var dateArray: [DateComponents] = []
                                if let startDate = task.startDate {
                                    dateArray.append(Calendar.current.dateComponents(
                                        in: TimeZone.current,
                                        from: startDate
                                    ))
                                }
                                if let endDate = task.endDate {
                                    dateArray.append(Calendar.current.dateComponents(
                                        in: TimeZone.current,
                                        from: endDate
                                    ))
                                }
                                
                                return Set(dateArray)
                            },
                            set: { newValue in
                                let dateArray = Array(newValue)
                                if dateArray.count > 1 {
                                    let stuff = dateArray.sorted { $0.date! < $1.date! }
                                    task.startDate = stuff.first?.date
                                    task.endDate = stuff.last?.date
                                } else {
                                    task.endDate = dateArray.first?.date
                                }
                            }
                        )
                    )
                }
                
                Spacer()
                
                if let likes = task.likes, !likes.isEmpty {
                    HStack(spacing: 2) {
                        Text("\(likes.count)")
                        Image(systemName: "hand.thumbsup")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                }
                
                if let comments = task.comments, !comments.isEmpty {
                    let filteredComments = comments.filter({ $0.status != .Sent })
					HStack(spacing: 2) {
						Text("\(filteredComments.count)")
						Image(systemName: "message")
					}
					.font(.caption2)
					.foregroundStyle(.secondary)
                }
                
                if let subtasks = task.subtasks, !subtasks.isEmpty {
                    Button {
                        withAnimation(.snappy) {
                            showSubtasks.toggle()
                        }
                    } label: {
                        HStack(spacing: 2) {
                            Text("\(subtasks.count)")
                            Image("subtask_icon")
                                .resizable()
                                .frame(width: 12, height: 12)
                            
                            if showSubtasks {
                                Image(systemName: "arrowtriangle.down.fill")
                            } else {
                                Image(systemName: "arrowtriangle.right.fill")
                            }
                        }
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.bordered)
                    .tint(.secondary)
                }
            }
            
			if showSubtasks, let subtasks = task.subtasks, !subtasks.isEmpty {
                ForEach(subtasks) { task in
                    @Bindable var task = task
                    TaskRowItem(task)
                        .font(.subheadline)
                }
                
                HStack {
                    Image(systemName: "plus")
                    Text("Add subtask")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme == .dark ? .black : .white)
                .strokeBorder(Color(uiColor: .systemGray5), lineWidth: 1)
        }
        .contentShape(.dragPreview, RoundedRectangle(cornerRadius: 10))
        .frame(maxWidth: 375, alignment: .leading)
        .onHover { hovering in
            isHovering = hovering
#if TARGET_OS_MACCATALYST
			DispatchQueue.main.async {
				if (self.isHovering) {
					NSCursor.pointingHand.push()
				} else {
					NSCursor.pop()
				}
			}
#endif
        }
        .contextMenu {
            TaskContextMenu(task)
        }
        .onTapGesture {
           
            if !task.name.isEmpty {
                asanaManager.selectedTask = task
            }
        }
    }
}

#Preview {
    @State var asanaManager = AsanaManager()
    return ZStack {
        Color(uiColor: .systemGray6)
        TaskCardView(.preview[0])
    }
    .environment(asanaManager)
}
