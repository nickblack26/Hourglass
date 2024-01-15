import SwiftUI

struct ProjectActionsMenu: View {
    @State private var showDetails: Bool = false
    @State private var showProjectPermissions: Bool = false
    @State private var showDuplicateProject: Bool = false
    @State private var showDeleteProject: Bool = false
    @Bindable var project: Project
    
    init(_ project: Project) {
        self.project = project
    }
    
    var body: some View {
        Menu {
            Section {
                Button("Edit project details", systemImage: "pencil") {
                    showDetails.toggle()
                }
                
                Button("Review project permissions", systemImage: "circle.hexagongrid.circle") {
                    showProjectPermissions.toggle()
                }
                
                Menu("Set color & icon", systemImage: "square.fill") {
                    ProjectThemeMenuContent(project)
                }
            }
            
            Section {
                Button("Copy project link", systemImage: "link") {
                    
                }
                
                Button("Duplicate", systemImage: "plus.square.on.square") {
                    showDuplicateProject.toggle()
                }
                
                Button("Save as template", systemImage: "doc.on.doc") {
                    
                }
                
                Button("Add to portffolio", systemImage: "plus") {
                    
                }
            }
            
            Section {
                Button("Archive", systemImage: "archivebox") {
                    
                }
                
                Button("Delete project", systemImage: "trash", role: .destructive) {
                    showDeleteProject.toggle()
                }
            }
            
        } label: {
            Image(systemName: "chevron.down")
        }
        .labelsHidden()
        .sheet(isPresented: $showDetails, content: {
            
        })
        .sheet(isPresented: $showProjectPermissions, content: {
            
        })
        .sheet(isPresented: $showDuplicateProject, content: {
            
        })
        .sheet(isPresented: $showDeleteProject, content: {
            DeleteProjectSheet(project)
        })
    }
}

#Preview {
    let project = Project(name: "")
    
    return ProjectActionsMenu(project)
        .modelContainer(previewContainer)
}
