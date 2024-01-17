import SwiftUI

struct ProjectToolbar: ToolbarContent {
    @Environment(HourglassManager.self) private var asana
    @Environment(\.modelContext) private var context
    var project: Project
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .primaryAction) {
            Button(
                "Edit project details",
                systemImage: "pencil"
            ) {
                project.starred.toggle()
            }
        }
        
        ToolbarItemGroup(placement: .primaryAction) {
            Button {
                project.starred.toggle()
            } label: {
                Circle()
                    .fill(ThemeColor.green.color)
                    .frame(width: 12, height: 12)
                
                Text("Status")
            }
            .font(.subheadline)
            .buttonStyle(.bordered)
            .tint(.green)
            .clipShape(Capsule())
        }
        
        ToolbarItem(placement: .primaryAction) {
            let isOnTheClock = asana.currentTimesheet != nil
            Button(
                isOnTheClock ? "End timer" : "Start timer",
                systemImage: isOnTheClock ? "stop.fill" : "play.fill"
            ) {
                guard let timesheet = asana.currentTimesheet else {
                    let newTimesheet = Timesheet(project: project, start: Date())
                    context.insert(newTimesheet)
                    asana.currentTimesheet = newTimesheet
                    return
                }
                timesheet.end = Date()
                asana.currentTimesheet = nil
            }
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
