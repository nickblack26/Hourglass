import SwiftUI

struct ProjectListItemContextMenu: View {
    @Bindable var project: Project
    
    init(_ project: Project) {
        self.project = project
    }
    
    var body: some View {
        Button(
            "Share project",
            systemImage: "person.2"
        ) {
            
        }
        
        Button(
            "Open in new tab",
            systemImage: "arrow.down.left.topright.rectangle"
        ) {
            
        }
        
        Button(
            "Copy link",
            systemImage: "link"
        ) {
            
        }
        
        Button(
            "Rename",
            systemImage: "pencil"
        ) {
            
        }
        
        Button(
            project.starred ? "Remove from starred" : "Add to starred",
            systemImage: "star"
        ) {
            withAnimation(.snappy) {
                project.starred.toggle()
            }
        }
        
        Button(
            "Archive project",
            systemImage: "archivebox"
        ) {
            withAnimation(.snappy) {
                project.archived.toggle()
            }
        }
    }
}

#Preview {
    let project = Project(name: "")

    return ProjectListItemContextMenu(project)
        .modelContainer(previewContainer)

}
