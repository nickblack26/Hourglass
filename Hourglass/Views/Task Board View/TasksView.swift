import SwiftUI

struct TasksView: View {
    @Environment(HourglassManager.self) private var hourglass
    @Binding var tasks: [aTask]?
    
    init(_ tasks: Binding<[aTask]?>) {
        self._tasks = tasks
    }
    
    var body: some View {
        @Bindable var hourglass = hourglass
        ForEach(tasks ?? []) { task in
            TaskCardView(task)
                .draggable(task) {
                    TaskCardView(task)
                        .onAppear {
                            hourglass.draggingTask = task
                        }
                        .environment(hourglass)
                }
                .dropDestination(for: aTask.self, action: { items, location in
                    hourglass.draggingTask = nil
                    return false
                }, isTargeted: { status in
                    if let _ = hourglass.draggingTask, status, hourglass.draggingTask != task {
                        withAnimation(.snappy) {
                            hourglass.draggingTask?.updateSection(section: task.section)
                            tasks?.replaceItem(
                                draggingTask: hourglass.draggingTask,
                                droppingTask: task,
                                section: task.section
                            )
                        }
                    }
                })
        }
    }
}

#Preview {
    TasksView(.constant([]))
}
