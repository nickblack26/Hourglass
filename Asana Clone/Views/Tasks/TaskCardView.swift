import SwiftUI

struct TaskCardView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) private var colorScheme
	@State private var showSubtasks: Bool = false
	@State private var isHovering: Bool = false
	@Bindable var task: TaskModel
    
    init(_ task: TaskModel) {
        self.task = task
    }

	let columns = Array(repeating: GridItem(), count: 5)
	
	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			HStack {
				LazyVGrid(columns: columns) {
					Capsule()
						.frame(height: 4)
						.foregroundStyle(.red)
					
					Capsule()
						.frame(height: 4)
						.foregroundStyle(.yellow)
					
					Capsule()
						.frame(height: 4)
						.foregroundStyle(.green)
					
					Capsule()
						.frame(height: 4)
						.foregroundStyle(.purple)
				}
			}
			
            HStack(alignment: .top) {
				Button {
                    withAnimation(.snappy) {
						task.isCompleted.toggle()
					}
				} label: {
					if task.isCompleted {
						Image(systemName: "checkmark.circle.fill")
							.foregroundStyle(.green)
							.listRowSeparator(.hidden)
					} else {
						Image(systemName: "checkmark.circle")
							.listRowSeparator(.hidden)
					}
				}
				
                TextField("Task name", text: $task.name, axis: .vertical)
			}
			.font(.subheadline)
			
			HStack {
				AvatarView(image: "IMG_0455.jpeg", fallback: "Nick Black", size: .tiny)
				
				if let endDate = task.endDate {
					Text(endDate, format: Date.FormatStyle().day().month())
						.font(.caption)
						.foregroundStyle(.green)
				}
				
				
				Spacer()
				
				Image(systemName: "hand.thumbsup")
					.font(.caption2)
					.foregroundStyle(.secondary)
				
				HStack(spacing: 0) {
					Text("1")
					Image(systemName: "message")
				}
				.font(.caption2)
				.foregroundStyle(.secondary)
				
				Button {
                    withAnimation(.snappy) {
						showSubtasks.toggle()
					}
				} label: {
					HStack(spacing: 0) {
						Text("1")
						Image(systemName: "message")
						
						if showSubtasks {
                            withAnimation(.snappy) {
								Image(systemName: "chevron.down")
							}
						} else {
                            withAnimation(.snappy) {
								Image(systemName: "chevron.right")
							}
						}
						
					}
					.font(.caption2)
					.foregroundStyle(.secondary)
				}
				.buttonStyle(.plain)
				
			}
			
			if showSubtasks {
                let subtasks = task.subtasks
                
                ForEach(subtasks) { task in
                    HStack {
                        Image(systemName: "checkmark.circle")
                            .foregroundStyle(.secondary)
                        Text(task.name)
                    }
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
		}
        .contextMenu(menuItems: {
            Button("Edit task name", systemImage: "pencil") {
                
            }
            
             Button("Add cover image", systemImage: "photo.on.rectangle.angled") {
                
            }
            
            Divider()
            
             Button("Leave task", systemImage: "bell") {
                
            }
            
             Button("Create follow-up task", systemImage: "circle.dotted") {
                
            }
            
            Divider()
            
            Button("Duplicate task", systemImage: "plus.square.on.square") {
                
            }
            
            Button("Mark complete", systemImage: "checkmark.circle") {
                
            }
            
            Divider()
            
            Button("Open details", systemImage: "sidebar.trailing") {
                
            }
            
            Button("Copy task link", systemImage: "link") {
                
            }
            
            Divider()
            
            Button("Delete", systemImage: "trash", role: .destructive) {
                withAnimation {
                    deleteTask()
                }
            }
        })
//        .draggable(task) {
//			TaskCardView(currentlyDragging: .constant(nil), currentlyDraggingSection: .constant(nil), task: task, section: section)
//				.onAppear {
//					currentlyDragging = task
//					currentlyDraggingSection = section
//				}
//		}
	}
    
    private func deleteTask() {
        context.delete(task)
    }
}

#Preview {
	ZStack {
		Color(uiColor: .systemGray6)
        TaskCardView(.preview[0])
	}
}
