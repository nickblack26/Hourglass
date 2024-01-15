import SwiftUI
import SwiftData
import Charts

struct ChartView: View {
    @Query private var tasks: [aTask]
    @Query private var projects: [Project]
    @Query private var sections: [aSection]
    var chart: aChart?
    var project: Project?
    var style: aChart.Style
    var source: aChart.Source
    
    init(project: Project? = nil, style: aChart.Style, source: aChart.Source) {
        if let projectId = project?.persistentModelID {
            self._sections = Query(
                filter: #Predicate<aSection> {
                    $0.project != nil && $0.project?.persistentModelID == projectId
                },
                sort: \.order
            )
        }
        
        self.project = project
        self.style = style
        self.source = source
    }
    
    var body: some View {
        let completedTasks = sections.reduce(0) { partialResult, section in
            guard let tasks = section.tasks else { return partialResult + 0 }
            return partialResult + tasks.filter({ $0.isCompleted }).count
        }
        let incompleteTasks = sections.reduce(0) { partialResult, section in
            guard let tasks = section.tasks else { return partialResult + 0 }
            return partialResult + tasks.filter({ !$0.isCompleted }).count
        }
        let overdueTasks = sections.reduce(0) { partialResult, section in
            guard let tasks = section.tasks else { return partialResult + 0 }
            return partialResult + tasks.filter({ !$0.isCompleted && $0.endDate != nil && ($0.endDate! < Date.now) }).count
        }
        let totalTasks = sections.reduce(0) { partialResult, section in
            guard let tasks = section.tasks else { return partialResult + 0 }
            return partialResult + tasks.count
        }
        
        if let chart {
            Card(.constant(false)) {
                VStack(alignment: .leading) {
                    Text(chart.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Button(
                        "^[1 filter](inflect: true)",
                        systemImage: "line.3.horizontal.decrease"
                    ) {
                        
                    }
                    
                    switch style {
                    case .column:
                        Chart(sections) { section in
                            BarMark(
                                x: .value("Shape Type", section.name),
                                y: .value("Total Count", section.tasks?.count ?? 0)
                            )
                            .foregroundStyle(project?.color.color ?? .accent)
                        }
                    case .line:
                        Chart(sections) { section in
                            LineMark(
                                x: .value("Shape Type", section.name),
                                y: .value("Total Count", section.tasks?.count ?? 0)
                            )
                            .foregroundStyle(project?.color.color ?? .accent)
                        }
                    case .burnup:
                        Chart(sections) { section in
                            AreaMark(
                                x: .value("Shape Type", section.name),
                                y: .value("Total Count", section.tasks?.count ?? 0),
                                stacking: .normalized
                            )
                            .foregroundStyle(by: .value("Section Name", section.name))
                        }
                    case .donut:
                        Chart(sections) { section in
                            SectorMark(
                                angle: .value("Tasks", section.tasks?.count ?? 0),
                                angularInset: 0.5
                            )
                            .cornerRadius(4)
                            .foregroundStyle(by: .value("Name", section.name))
                        }
                        
                    case .number:
                        Text("100")
                            .font(.title)
                        
                    default:
                        Chart(sections) { section in
                            BarMark(
                                x: .value("Shape Type", section.name),
                                y: .value("Total Count", section.tasks?.count ?? 0)
                            )
                            .foregroundStyle(project?.color.color ?? .accent)
                        }
                    }
                }
            }
            .frame(maxHeight: 200)
        }
    }
}

#Preview {
    ChartView(style: .column, source: .tasks)
}
