import SwiftUI

struct TaskRowItem: View {
    @Environment(AsanaManager.self) private var asanaManager
    @State private var isHovering: Bool = false
    @Bindable var task: Task
    
    init(_ task: Task) {
        self.task = task
    }
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        HStack {
            Button {
                withAnimation {
                    task.isCompleted.toggle()
                    if task.isCompleted {
                        task.completedAt = Date()
                    }
                }
            } label: {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                    .symbolRenderingMode(task.isCompleted ? .hierarchical : .monochrome)
                    .foregroundStyle(task.isCompleted ? .green : .secondary)
            }
            .help("Mark task \(task.isCompleted ? "incomplete" : "complete")")
            
            TextField("Task name", text: $task.name)
            
            if isHovering {
                Button {} label: {
                    Image(systemName: "calendar")
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
                        
            if isHovering {
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
            
            if isHovering {
                Image(systemName: "message")
                Image(systemName: "chevron.right")
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background(isHovering ? Color(uiColor: .systemGray6) : .clear)
        .onHover(perform: { hovering in
            isHovering = hovering
            DispatchQueue.main.async {
                if (self.isHovering) {
                    NSCursor.pointingHand.push()
                } else {
                    NSCursor.pop()
                }
            }
        })
        .onTapGesture {
            asanaManager.selectedTask = task
        }
    }
}

#Preview {
    TaskRowItem(.preview[0])
}
