import SwiftUI

struct ProjectActionsMenu: View {
	@Environment(\.modelContext) private var context
    @State private var showDetails: Bool = false
    @State private var showProjectPermissions: Bool = false
    @State private var showDuplicateProject: Bool = false
    @State private var showDeleteProject: Bool = false
    @Bindable var project: Project
    
    init(_ project: Project) {
        self.project = project
    }
    
    var body: some View {
		Menu(
			"Project actions",
			systemImage: "chevron.down"
		) {
            Section {
                Button(
                    "Edit project details",
                    systemImage: "pencil"
                ) {
                    showDetails.toggle()
                }
                
                Button(
                    "Review project permissions",
                    systemImage: "circle.hexagongrid.circle"
                ) {
                    showProjectPermissions.toggle()
                }
                
                Menu(
                    "Set color & icon",
                    systemImage: "square.fill"
                ) {
                    ProjectThemeMenuContent(project)
                }
            }
            
            Section {
                Button(
                    "Copy project link",
                    systemImage: "link"
                ) {
                    
                }
                
                Button(
                    "Duplicate",
                    systemImage: "plus.square.on.square"
                ) {
                    showDuplicateProject.toggle()
                }
                
                Button(
                    "Save as template",
                    systemImage: "doc.on.doc"
                ) {
                    
                }
                
                Button(
                    "Add to portfolio",
                    systemImage: "plus"
                ) {
                    
                }
            }
            
            Section {
				Button(
					project.archived ? "Unarchive" : "Archive",
					systemImage: project.archived ? "archivebox" : "archivebox.fill"
				) {
					withAnimation(.snappy) {
						project.archived.toggle()
					}
                }
                
				Button(
					"Delete project",
					systemImage: "trash",
					role: .destructive
				) {
					withAnimation(.snappy) {
						context.delete(project)
					}
                }
            }
        }
        .sheet(isPresented: $showDetails) {
            NavigationStack {
                ProjectDetailView(project)
            }
        }
    }
}

#Preview {
    let project = Project(name: "")
    
    return ProjectActionsMenu(project)
        .modelContainer(previewContainer)
}
