import SwiftUI
import SwiftData

enum MyTasksTab: String, CaseIterable {
    case upcoming = "Upcoming"
    case overdue = "Overdue"
    case completed = "Completed"
}

func getCurrentWeeksDates() -> [Date] {
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())
    let dayOfWeek = calendar.component(.weekday, from: today)
    let dates = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
        .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }    
    return dates
}

struct MyTasksWidget: View {
    @Environment(AsanaManager.self) private var asanaManager
    static var now: Date { Date.now }
    
    @Query(
        filter: #Predicate<Task> { task in
            if !task.isCompleted {
                if let endDate = task.endDate {
                    if endDate > now {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            } else {
                return false
            }
        },
        sort: \Task.order
    )
    private var upcomingTasks: [Task]
    
    @Query(
        filter: #Predicate<Task> { task in
            if !task.isCompleted {
                if let endDate = task.endDate {
                    if endDate > now {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            } else {
                return false
            }
        },
        sort: \Task.order)
    private var overdueTasks: [Task]
    
    @Query(
        filter: #Predicate<Task> { $0.isCompleted },
        sort: \Task.order
    )
    private var completedTasks: [Task]
    
    @State private var tabSelection: MyTasksTab = .upcoming
    @State private var selectedTask: Task? = nil
    @State private var openSheet: Bool = false
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        
        List {
            SwiftUI.Section {
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
                HStack(spacing: 20) {
                    AvatarView(
                        image: tempUrl,
                        fallback: "Nick Black",
                        size: .xlarge
                    )
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("My tasks")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
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
                .foregroundStyle(.primary)
            }
        }
        .scrollContentBackground(.hidden)
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
        .modelContainer(for: Task.self)
}
