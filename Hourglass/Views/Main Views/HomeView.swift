import SwiftUI
import SwiftData

struct HomeView: View {
    static var weekStartDate: Date = Date().startOfWeek()
    static var monthStartDate: Date = Date().startOfMonth()
    
    // MARK: Environment Variables
    @Environment(CloudKitManager.self) private var cloudKitManager
    @Environment(HourglassManager.self) private var asanaManager
    
    // MARK: Data Variables
    @Query(sort: \aTask.order )
    private var tasks: [aTask]
    
    @Query(
        filter: #Predicate<aTask> { 
            $0.isCompleted && $0.completedAt != nil && $0.completedAt! >= weekStartDate
        }
    )
    private var weeklyTaskCompleted: [aTask]
    
    @Query(
        filter: #Predicate<aTask> {
            $0.isCompleted && $0.completedAt != nil && $0.completedAt! >= monthStartDate
        }
    )
    private var monthlyTasksCompleted: [aTask]
	
	var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("Home")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 64)
                
                VStack {
                    VStack {
                        Text(Date.now.getFormattedDate())
                            .font(.title3)
                            .fontWeight(.medium)
                        
                        Text("Good afternoon, \(cloudKitManager.userName.isEmpty ? "User" : cloudKitManager.userName)")
                            .font(.largeTitle)
                            .fontWeight(.regular)
                    }
                    
                    HStack {
                        Spacer()
                        Spacer()
                                                
                        AchievmentsWidgetView(number: (weeklyTaskCompleted.count, monthlyTasksCompleted.count), collaborators: 1)
                        
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
                
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 32) {
                        ForEach(asanaManager.availableWidgets) { widget in
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
                }
                .frame(maxWidth: 1575)
            }
        }
		.padding()
	}
}

#Preview {
    @State var cloudKitManager = CloudKitManager()
    @State var asanaManager = HourglassManager()
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
