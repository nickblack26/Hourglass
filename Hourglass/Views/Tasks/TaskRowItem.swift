import SwiftUI

struct TaskRowItem: View {
    @Environment(HourglassManager.self) private var hourglass
    @State private var isHovering: Bool = false
    @Bindable var task: aTask
    
    init(_ task: aTask) {
        self.task = task
    }
    
    var body: some View {
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
#if os(iOS)
        .background(isHovering ? Color(uiColor: .systemGray6) : .clear)
#endif
#if os(macOS)
        .background(isHovering ? Color(nsColor: .systemGray) : .clear)
#endif
        .onHover(perform: { hovering in
            isHovering = hovering
        })
        .onTapGesture {
            if !task.name.isEmpty {
                hourglass.selectedTask = task
            }
        }
    }
}

#Preview {
    let task = aTask(name: "", order: 0)

    return TaskRowItem(task)
        .modelContainer(previewContainer)

}
