import SwiftUI
import SwiftData

struct HomeView: View {
    // MARK: Environment Variables
    @Environment(CloudKitManager.self) private var cloudKitManager
    @Environment(AsanaManager.self) private var asanaManager
    @Environment(\.colorScheme) var backgroundColor
    
    // MARK: Data Variables
    @Query private var tasks: [TaskModel]
    
    // MARK: State Variables
	@State private var taskTab: String = "Upcoming"
	@State private var selectedTask: TaskModel? = nil
	@State private var openSheet: Bool = false
	@State private var showInspector: Bool = false
	@State private var colorScheme: ColorScheme = .white
		
	func getFormattedDate() -> String {
		let today = Date()
		let calendar = Calendar.current
		let f = DateFormatter()
		
		let day = f.weekdaySymbols[calendar.component(.weekday, from: today) - 1]
		let month = f.monthSymbols[calendar.component(.month, from: today) - 1]
		let dayNum = calendar.component(.day, from: today)
		
		return "\(day), \(month) \(dayNum)"
	}
	
	var body: some View {
        @Bindable var asanaManager = asanaManager

		VStack {
			VStack {
				Text("\(getFormattedDate())")
					.font(.title3)
					.fontWeight(.medium)
				
                Text("Good afternoon, \(cloudKitManager.userName)")
					.font(.largeTitle)
					.fontWeight(.regular)
			}
			
			HStack {
				Spacer()
				Spacer()
				
                AchievmentsWidgetView(number: tasks.count, collaborators: 1)
				
				Spacer()
				
				Button {
                    asanaManager.showHomeCustomization.toggle()
				} label: {
					Label("Customize", systemImage: "rectangle.badge.plus")
				}
				.buttonStyle(.plain)
				.padding(.horizontal)
				.padding(.vertical, 10)
				.background {
					RoundedRectangle(cornerRadius: 5)
						.stroke(.cardBorder, lineWidth: 1)
						.fill(.cardBackground)
				}
			}
			
			LazyVGrid(columns: [GridItem(),GridItem()], spacing: 16) {
                ForEach(asanaManager.currentMember?.widgets ?? []) { widget in
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
					.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		}
		.padding()
		.frame(maxWidth: 1200)
		.navigationTitle("Home")
		.background {
			if(backgroundColor == .dark && colorScheme == .white) {
				Image("\(colorScheme.preferences.image)_background")
					.resizable()
					.scaledToFill()
					.edgesIgnoringSafeArea(.all)
			} else if (colorScheme != .white) {
				Image("\(colorScheme.preferences.image)_background")
					.resizable()
					.scaledToFill()
					.edgesIgnoringSafeArea(.all)
			}
		}
	}
}

#Preview {
    @State var cloudKitManager = CloudKitManager()
    @State var asanaManager = AsanaManager()
	return NavigationStack {
		ScrollView {
			HomeView()
		}
	}
    .environment(cloudKitManager)
    .environment(asanaManager)
}


//                    .dropDestination(for: WidgetOptionModel.self) { items, location in
//                        return false
//                    } isTargeted: { status in
//                        let option = widget
                        
                        
//                        if let draggingItem, status, draggingItem != option {
//                                if let sourceIndex = vm.availableWidgets.firstIndex(of: draggingItem), let destinationIndex = vm.homeWidgets.firstIndex(of: vm.homeWidgets[index]) {
//                                    withAnimation {
//                                        let sourceItem = vm.availableWidgets.remove(at: sourceIndex)
//                                        vm.homeWidgets.insert(sourceItem, at: destinationIndex)
//                                    }
//                                }
//                        }
//                    }
