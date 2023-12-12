import SwiftUI
import SwiftData

struct ProjectsWidget: View {
    @Query private var projects: [ProjectModel]
	// eventually be able to pass the amount of columns to show
	// this will depend on whether or not the card is full width or not
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
			
//			LazyVGrid(alignment: .center) {
//				GridRow(alignment: .top) {
//					NavigationLink(destination: NewProjectView()) {
//						HStack {
//							Image(systemName: "plus")
//								.foregroundStyle(.secondary)
//								.padding()
//								.background {
//									RoundedRectangle(cornerRadius: 5)
//										.strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [1]))
//								}
//							
//							Text("Create project")
//						}
//					}
//					
//					List(vm.projects) { project in
//						HStack {
//							Image(systemName: "list.bullet")
//								.symbolRenderingMode(.hierarchical)
//								.padding()
//								.background {
//									RoundedRectangle(cornerRadius: 5)
//										.fill(.mint)
//								}
//							VStack(alignment: .leading) {
//								Text(project.name)
//									.lineLimit(1)
//									.fontWeight(.semibold)
//								
//								Text("3 tasks due soon")
//									.foregroundStyle(.secondary)
//									.lineLimit(1)
//							}
//						}
//						.listRowSeparator(.hidden)
//						.listRowBackground(EmptyView())
//					}
//					.listStyle(.plain)
//				}
//			}
			
			Spacer()
		}
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
    @Environment(AsanaManager.self) private var asanaManager
    @State private var isHovering: Bool = false
    var project: ProjectModel
    
    init(_ project: ProjectModel) {
        self.project = project
    }
    
    var body: some View {
        let calendar = Calendar.current
        let addOneWeekToCurrentDate = calendar.date(byAdding: .weekOfYear, value: 2, to: Date())
        let upcomingTasks = project.tasks.filter {
            $0.endDate != nil && $0.endDate! > addOneWeekToCurrentDate!
        }
        
        NavigationLink(value: project) {
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
                        if upcomingTasks.count > 0 {
                            Text("\(upcomingTasks.count) tasks due soon")
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        }
                    }
                }
            }
        }
        .onHover(perform: { isHovering = $0 })
    }
}

#Preview("Project List Item") {
    ProjectListItemView(.preview)
}
