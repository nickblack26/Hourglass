import SwiftUI

struct ProjectListItemContextMenu: View {
    @Bindable var project: Project
    
    init(_ project: Project) {
        self.project = project
    }
    
    var body: some View {
        Button("Share project", systemImage: "person.2") {
            
        }
        
        Button("Open in new tab", systemImage: "arrow.down.left.topright.rectangle") {
            
        }
        
        Button("Copy link", systemImage: "link") {
            
        }
        
        Menu("Copy link", systemImage: "link") {
            ProjectThemeMenuContent(project)
        }
        
        Button("Rename", systemImage: "pencil") {
            
        }
        
        Button(project.starred ? "Remove from starred" : "Add to starred", systemImage: "star") {
            project.starred.toggle()
        }
        
        Button("Archive project", systemImage: "archivebox") {
            project.archived.toggle()
        }
    }
}

#Preview {
    ProjectListItemContextMenu(.preview)
}
