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
				NavigationLink(destination: NewProjectView(isPresented: .constant(true))) {
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
                    ProjectListItemView(project)
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

struct ProjectListItemView: View {
    @Environment(HourglassManager.self) private var hourglass
    @State private var isHovering: Bool = false
    var project: Project
    
    init(_ project: Project) {
        self.project = project
    }
    
    var body: some View {
        let calendar = Calendar.current
        let addOneWeekToCurrentDate = calendar.date(byAdding: .weekOfYear, value: 2, to: Date())
		let upcomingTasks = project.tasks?.filter {
            $0.endDate != nil && $0.endDate! > addOneWeekToCurrentDate!
        }
        
        HStack {
            Image(project.icon.icon)
                .padding()
                .background(project.color.color)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(project.name)
                    .lineLimit(1)
                    .fontWeight(.semibold)
                
                if project.archived {
                    Label("Archived", systemImage: "archivebox.fill")
                        .font(.caption)
                } else {
                    if let upcomingTasks, upcomingTasks.count > 0 {
                        Text("\(upcomingTasks.count) tasks due soon")
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }
            }
            
            if isHovering {
                Menu {
                    Button("Share...", systemImage: "person.2") {
                        
                    }
                    
                    Button("Add to starred", systemImage: "star") {
                        
                    }
                    
                    Menu {
                        
                    } label: {
                        HStack {
                            Rectangle()
                            
                            Text("Set color & icon")
                        }
                    }
                    
                    Button("Edit project details", systemImage: "pencil") {
                        
                    }
                    
                    Button("Copy project link", systemImage: "link") {
                        
                    }
                    
                    Button("Archive", systemImage: "archivebox") {
                        
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .onTapGesture {
            hourglass.selectedLink = .project(project)
        }
        .onHover(perform: {
            isHovering = $0
#if targetEnvironment(macCatalyst)
            DispatchQueue.main.async {
                if (self.isHovering) {
                    NSCursor.pointingHand.push()
                } else {
                    NSCursor.pop()
                }
            }
#endif
        })
    }
}

#Preview("Project List Item") {
    @State var hourglass = HourglassManager()
    let project = Project(name: "")

    
    return NavigationStack { ProjectListItemView(project) }
        .environment(hourglass)
        .modelContainer(previewContainer)

}
