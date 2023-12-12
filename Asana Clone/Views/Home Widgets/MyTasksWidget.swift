import SwiftUI
import SwiftData

enum MyTasksTab: String, CaseIterable {
    case upcoming = "Upcoming"
    case overdue = "Overdue"
    case completed = "Completed"
}

struct MyTasksWidget: View {
    @Environment(AsanaManager.self) private var asanaManager
    static var now: Date { Date.now }
//    @Query(filter: #Predicate<TaskModel> { task in
//        task.endDate != nil && task.endDate! > now && !task.isCompleted
//    })
    @Query private var upcomingTasks: [TaskModel]
    
//    @Query(filter: #Predicate<TaskModel> { task in
//        task.endDate != nil && task.endDate! < now && !task.isCompleted
//    })
    @Query private var overdueTasks: [TaskModel]
    
//    @Query(filter: #Predicate<TaskModel> { $0.isCompleted })
    @Query private var completedTasks: [TaskModel]
    
    @State private var tabSelection: MyTasksTab = .upcoming
    @State private var selectedTask: TaskModel? = nil
    @State private var openSheet: Bool = false
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        
        List {
            Section {
                switch tabSelection {
                case .upcoming:
                    if upcomingTasks.isEmpty {
                        VStack {
                            Image("large-checkmark-with-three-colorful-bubbles")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 200)
                            Text("You don't have any overdue tasks. Nice!")
                        }
                        .listRowSeparator(.hidden)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    } else {
                        ForEach(upcomingTasks) { task in
                            HStack {
                                Button {
                                    
                                } label: {
                                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                                        .foregroundStyle(task.isCompleted ? .green : .primary)
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    selectedTask = task
                                    openSheet.toggle()
                                } label: {
                                    Text(task.name)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .listStyle(.plain)
                    }
                case .overdue:
                    if overdueTasks.isEmpty {
                        VStack {
                            Image("large-checkmark-with-three-colorful-bubbles")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 200)
                            Text("You don't have any upcoming tasks. Nice!")
                        }
                        .listRowSeparator(.hidden)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    } else {
                        ForEach(overdueTasks) { task in
                            HStack {
                                Button {
                                    
                                } label: {
                                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                                        .foregroundStyle(task.isCompleted ? .green : .primary)
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    selectedTask = task
                                    openSheet.toggle()
                                } label: {
                                    Text(task.name)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .listStyle(.plain)
                    }
                case .completed:
                    if completedTasks.isEmpty {
                        VStack {
                            Image("large-checkmark-with-three-colorful-bubbles")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 200)
                            Text("You don't have any overdue tasks. Nice!")
                        }
                        .listRowSeparator(.hidden)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    } else {
                        ForEach(completedTasks) { task in
                            HStack {
                                Button {
                                    
                                } label: {
                                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                                        .foregroundStyle(task.isCompleted ? .green : .primary)
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    selectedTask = task
                                    openSheet.toggle()
                                } label: {
                                    Text(task.name)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
            } header: {
                HStack {
                    Image("profile")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .cornerRadius(50)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("My Tasks")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Image(systemName: "lock.fill")
                                .foregroundStyle(.secondary)
                                .font(.footnote)
                        }
                        
                        HStack {
                            ForEach(MyTasksTab.allCases, id: \.self) { tab in
                                Button {
                                    tabSelection = tab
                                } label: {
                                    Text(tab.rawValue)
                                        .foregroundStyle(tabSelection == tab ? .primary : .secondary )
                                        .padding(.trailing, 5)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .padding()
        .frame(height: 400)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.cardBackground)
                .stroke(.cardBorder, lineWidth: 1)
        }
        .contentShape(.dragPreview, RoundedRectangle(cornerRadius: 10))
//        .draggable(MyTasksWidget) {
//            MyTasksWidget()
//                .onAppear {
//                    asanaManager.draggingWidget = MyTasksWidget
//                }
//        }
    }
}

#Preview {
    MyTasksWidget()
        .modelContainer(for: TaskModel.self)
}
