import SwiftUI
import SwiftData

struct HomeView: View {
    // MARK: Environment Variables
    @Environment(CloudKitManager.self) private var cloudKitManager
    @Environment(HourglassManager.self) private var hourglass
	
	// MARK: State Variables
	@State private var searchText: String = ""
	@State private var colorScheme: ColorScheme = .white
	@State private var showCustomization: Bool = false
    
    // MARK: Data Variables
    @Query(sort: \aTask.order )
    private var tasks: [aTask]
	
	var body: some View {
        ScrollView {
			VStack {
				Text(Date.now.getFormattedDate())
					.font(.title3)
					.fontWeight(.medium)
				
				Text("Good afternoon, \(cloudKitManager.userName.isEmpty ? "User" : cloudKitManager.userName)")
					.font(.largeTitle)
					.fontWeight(.regular)
			}
			.listRowSeparator(.hidden)
			.frame(
				maxWidth: .infinity,
				alignment: .center
			)
			
			LazyVGrid(
				columns: [GridItem(), GridItem()],
				spacing: 32
			) {
				ForEach(hourglass.availableWidgets) { widget in
					ZStack {
						switch widget.type {
							case .myTasks:
								MyTasksWidget()
							case .people:
								Text(widget.name)
							case .projects:
								ProjectsWidget()
							case .notepad:
								PrivateNotepadWidgetView()
							case .tasksAssigned:
								Text(widget.name)
							case .draftComments:
								Text(widget.name)
							case .forms:
								Text(widget.name)
							case .myGoals:
								Text(widget.name)
						}
					}
				}
			}
			.listRowSeparator(.hidden)
			.frame(
				maxWidth: 1575,
				alignment: .center
			)
        }
        .padding()
        .scrollIndicators(.hidden)
		.searchable(text: $searchText)
		.navigationTitle("Home")
		.toolbar {
			ToolbarItem {
				Button("Customize", systemImage: "square.grid.2x2") {
					showCustomization.toggle()
				}
			}
		}
		.inspector(isPresented: $showCustomization) {
			HomeInspector(colorScheme: $colorScheme)
		}
	}
}

#Preview {
    @State var cloudKitManager = CloudKitManager()
    @State var hourglass = HourglassManager()
	return NavigationStack {
		ScrollView {
			HomeView()
		}
	}
    .environment(cloudKitManager)
    .environment(hourglass)
}
