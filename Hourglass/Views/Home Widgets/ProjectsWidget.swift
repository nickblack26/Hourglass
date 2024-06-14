import SwiftUI
import SwiftData

struct ProjectsWidget: View {
    @Query private var projects: [Project]
	let colNum = 2
	
	var body: some View {
		VStack(alignment: .leading) {
			Text("Projects")
				.font(.title2)
				.fontWeight(.bold)
			
			let columns = Array(repeating: GridItem(spacing: 15), count: colNum)
			
			LazyVGrid(columns: columns, alignment: .leading, spacing: 15) {
                NavigationLink(
                    destination: ProjectDetailView()
                ) {
					HStack {
						Image(systemName: "plus")
							.foregroundStyle(.secondary)
							.padding()
							.background {
								RoundedRectangle(cornerRadius: 5)
									.strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [2]))
							}
						
						Text("Create project")
					}
				}
                
				ForEach(projects) { project in
                    ProjectListItem(
                        title: project.name,
                        subtitle: project.client?.name,
                        color: project.color.color
                    )
				}
			}
		}
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
		.padding()
		.frame(height: 400)
		.background {
			RoundedRectangle(cornerRadius: 10)
				.fill(.cardBackground)
				.stroke(.cardBorder, lineWidth: 1)
		}
	}
}

#Preview {
	ProjectsWidget()
}
