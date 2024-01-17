import SwiftUI

struct ProjectToolbar: ToolbarContent {
    @Environment(HourglassManager.self) private var asana
    @Environment(\.modelContext) private var context
    var project: Project
    
    var body: some ToolbarContent {
		ToolbarItem(placement: .topBarLeading) {
			Image(project.icon.icon)
				.resizable()
				.frame(width: 12, height: 12)
				.padding(8)
				.background(project.color.color, in: .rect(cornerRadius: 8))
		}
		
		ToolbarItemGroup(placement: .primaryAction) {
			ShareLink(
				project.name,
				item: project,
				preview: .init(
					project.name,
					icon: Image(project.icon.icon)
				)
			)
			.tint(project.color.color)
			
			Button(
				project.starred ? "Unfavorite" : "Favorite",
				systemImage: project.starred ? "star.fill" : "star"
			) {
				withAnimation(.snappy) {
					project.starred.toggle()
				}
			}
			.tint(project.color.color)
			
			
			ProjectActionsMenu(project)
				.tint(project.color.color)
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
