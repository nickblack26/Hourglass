import SwiftUI
import SwiftData


struct HomeView: View {
    static var weekStartDate: Date { Date().startOfWeek() }
    static var monthStartDate: Date { Date().startOfMonth() }
    
    // MARK: Environment Variables
    @Environment(CloudKitManager.self) private var cloudKitManager
    @Environment(AsanaManager.self) private var asanaManager
    @Environment(\.colorScheme) var backgroundColor
    
    // MARK: Data Variables
    @Query(sort: \aTask.order )
    private var tasks: [aTask]
    
    @Query(filter: #Predicate<aTask> { $0.isCompleted && $0.completedAt != nil && $0.completedAt! >= weekStartDate } )
    private var weeklyTaskCompleted: [aTask]
    
    @Query(filter: #Predicate<aTask> { $0.isCompleted && $0.completedAt != nil && $0.completedAt! >= monthStartDate } )
    private var monthlyTasksCompleted: [aTask]
    
    // MARK: State Variables
	@State private var colorScheme: ColorScheme = .white
		
	
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
                    
                    let gridItems = [
                        GridItem(.fixed(500), spacing: 32, alignment: .leading),
                        GridItem(.fixed(500), spacing: 32, alignment: .leading)
                    ]
                    
                    
                    Grid {
                        GridRow {
                            Color.clear
                            Color.clear
                        }
                        let widgets = asanaManager.availableWidgets
                        var widgetTotal = widgets.count
                        ForEach(widgets.indices, id: \.self) { index in
                            if index != widgetTotal {
                                
                            }
                            GridRow {
                                ZStack {
                                    switch widgets[index].type {
                                        case .myTasks:
                                            MyTasksWidget()
                                        case .people:
                                            Text(widgets[index].name)
                                        case .projects:
                                            ProjectsWidget()
                                        case .notepad:
                                            PrivateNotepadWidgetView()
                                        case .tasksAssigned:
                                            Text(widgets[index].name)
                                        case .draftComments:
                                            Text(widgets[index].name)
                                        case .forms:
                                            Text(widgets[index].name)
                                        case .myGoals:
                                            Text(widgets[index].name)
                                    }
                                }
                                .gridCellColumns(widgets[index].columns)
                            }
                        }
                    }
                    
                    
//                    LazyVGrid(columns: gridItems, spacing: 32) {
//                        ForEach(asanaManager.availableWidgets) { widget in

//                            .frame(
//                                width: widget.columns == 2 ? 1032 : .infinity,
//                                height: 400
//                            )
////                            .frame(
////                                maxWidth: .infinity,
////                                maxHeight: .infinity,
////                                alignment: .topLeading
////                            )
////                            .frame(
////                                maxWidth: .infinity,
////                                maxHeight: .infinity,
////                                alignment: .topLeading
////                            )
////                            .padding(8)
//                            
//                            if widget.columns == 2 { Color.clear }
//                        }
//                    }
//                    .frame(
//                        maxWidth: .infinity,
//                        maxHeight: .infinity,
//                        alignment: .topLeading
//                    )
                }
                .frame(maxWidth: 1575)
            }
        }
		.padding()
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
