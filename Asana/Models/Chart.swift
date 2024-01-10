import Foundation
import SwiftData

@Model
final class Chart {
    let color: AsanaColor = AsanaColor.none
    let name: String
    let source: Source = Source.tasks
//    let filters: AnyKeyPath? = nil
    let style: Style = Style.column
    let rollupStyle: RollupCalculation?
    let dashboard: Dashboard?
    
    init(
        color: AsanaColor = AsanaColor.none,
        name: String,
        source: Chart.Source = Source.tasks,
        style: Chart.Style = Style.column,
        rollupStyle: RollupCalculation? = nil
    ) {
        self.name = name
        self.name = name
        self.name = name
        self.name = name
        self.rollupStyle = rollupStyle
    }
}

extension Chart {
    enum Style: String, CaseIterable, Codable {
        case column, line, burnup, donut, number, lollipop
    }
    
    enum Source: String, CaseIterable, Codable {
        case tasks, projects, portfolios, goals
    }
    
    enum RollupCalculation: String, CaseIterable, Codable {
        case sum, average
    }
}

extension Chart {
//    static func recommendedCharts() -> [Chart] {
//        [
//            .init(title: "Incomplete tasks by project", image: "green_column_chart"),
//            .init(title: "Project by status", image: "donut_status")
//        ]
//    }
//    
//    static func resourcingCharts() -> [Chart] {
//        [
//            .init(title: "Goals by team", image: "upcoming_tasks_by_project"),
//            .init(title: "Upcoming tasks by assignee this week", image: "lollipop_aqua"),
//            .init(title: "This month's tasks by project", image: "this_months_tasks_by_project"),
//            .init(title: "Custom field total", image: "numeric_rollup"),
//            .init(title: "Project by owner", image: "lollipop_purple"),
//            .init(title: "Project by portfolio", image: "bar_multicolored"),
//            .init(title: "Tasks by creator", image: "lollipop_aqua")
//        ]
//    }
//    
//    static func workHealth() -> [Chart] {
//        [
//            .init(title: "Time in custom field", image: "bar_multicolored"),
//            .init(title: "Tasks by custom field", image: "lollipop_aqua"),
//            .init(title: "Overdue tasks by project", image: "red_column_chart"),
//            .init(title: "Upcoming tasks by project", image: "upcoming_tasks_by_project"),
//            .init(title: "Custom field total by project", image: "bar_purple"),
//            .init(title: "Projects by custom field", image: "donut_multicolored"),
//            .init(title: "Goals by status", image: "donut_status")
//        ]
//    }
//    
//    static func progress() -> [Chart] {
//        [
//            .init(title: "Projects with the most completed tasks", image: "green_column_chart"),
//            .init(title: "Tasks by completion status this month", image: "tasks_by_completion_status_this_month"),
//            .init(title: "Tasks completed by month", image: "line_blue")
//        ]
//    }
}
