import SwiftUI
import SwiftData
import Charts

struct ChartView: View {
    @Query private var tasks: [aTask]
    @Query private var projects: [Project]
    @Query private var sections: [aSection]
    var project: Project?
    var style: aChart.Style
    var source: aChart.Source
    
    init(project: Project? = nil, style: aChart.Style, source: aChart.Source) {
        if let projectId = project?.id {
            self._sections = Query(
                filter: #Predicate<aSection> {
                    $0.project != nil && $0.project!.id == projectId
                },
                sort: \.order
            )
        }
        
        self.project = project
        self.style = style
        self.source = source
    }
    
    var body: some View {
        let completedTasks = tasks.filter({ $0.isCompleted })
        let inCompleteTasks = tasks.filter({ !$0.isCompleted })
        Card(.constant(false)) {
            VStack(alignment: .leading) {
                Chart {
                    switch style {
                    case .column:
                        ForEach(sections) { section in
                            BarMark(
                                x: .value("Shape Type", section.name),
                                y: .value("Total Count", section.tasks?.count ?? 0)
                            )
                            .foregroundStyle(project?.color.color ?? .accent)
                        }
                    case .line:
                        ForEach(sections) { section in
                            LineMark(
                                x: .value("Shape Type", section.name),
                                y: .value("Total Count", section.tasks?.count ?? 0)
                            )
                            .foregroundStyle(project?.color.color ?? .accent)
                        }
                    case .burnup:
                        ForEach(sections) { section in
                            AreaMark(
                                x: .value("Shape Type", section.name),
                                y: .value("Total Count", section.tasks?.count ?? 0),
                                stacking: .normalized
                            )
                            .foregroundStyle(by: .value("Section Name", section.name))
                        }
                    case .donut:
                        ForEach(sections) { section in
                            SectorMark(
                                angle: .value("Tasks", section.tasks?.count ?? 0),
                                angularInset: 0.5
                            )
                            .cornerRadius(4)
                            .foregroundStyle(by: .value("Name", section.name))
                        }
                    default:
                        ForEach(sections) { section in
                            BarMark(
                                x: .value("Shape Type", section.name),
                                y: .value("Total Count", section.tasks?.count ?? 0)
                            )
                            .foregroundStyle(project?.color.color ?? .accent)
                        }
                    }
                }
            }
        }
        .frame(maxHeight: 200)
    }
}

#Preview {
    ChartView(style: .column, source: .tasks)
}
