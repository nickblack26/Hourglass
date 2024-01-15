import SwiftUI

struct ProjectStatusMenu: View {
    @Bindable var project: Project
    
    init(_ project: Project) {
        self.project = project
    }
    
    var body: some View {
        Menu {
            Section {
                ForEach(Project.Status.allCases, id: \.self) { status in
                    if status != .complete {
                        Button(status.rawValue, systemImage: "circle.fill") {
                            project.status = status
                        }
                        .foregroundStyle(status.color.color)
                    }
                }
            }
            
            Section {
                Button {
                    project.status = .complete
                } label: {
                    Label("Complete", systemImage: "checkmark")
                }
                .imageScale(.small)
                .foregroundStyle(.green)
            }
        } label: {
            Image(systemName: project.status == nil ? "circle" : "circle.fill")
            Text(project.status?.rawValue ?? "Set status")
            if let _ = project.status {
                Image(systemName: "chevron.down")
            }
        }
        .font(.caption)
        .buttonStyle(.bordered)
        .tint(project.status?.color.color ?? .secondary)
        .clipShape(Capsule())
    }
}

#Preview {
    let project = Project(name: "")

    return ProjectStatusMenu(project)
        .modelContainer(previewContainer)

}
