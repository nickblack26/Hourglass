import SwiftUI

struct TaskContextMenu: View {
    @Environment(HourglassManager.self) private var hourglass
    @Environment(\.modelContext) private var context
    @Bindable var task: aTask
    
    init(_ task: aTask) {
        self.task = task
    }
    
    var body: some View {
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
            context.insert(task)
        }
        
        Button("Mark complete", systemImage: "checkmark.circle") {
            task.isCompleted = true
        }
        
        Divider()
        
        Button("Open details", systemImage: "sidebar.trailing") {
            hourglass.selectedTask = task
        }
        
        Button("Copy task link", systemImage: "link") {
            
        }
        
        Divider()
        
        Button("Delete", systemImage: "trash", role: .destructive) {
            withAnimation {
                deleteTask()
            }
        }
    }
    
    private func deleteTask() {
        context.delete(task)
    }
}

#Preview {
    let task = aTask(name: "", order: 0)

    return TaskContextMenu(task)
        .modelContainer(previewContainer)

}
