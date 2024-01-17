import Foundation
import SwiftData

@Model
final class aChart {
    var color: ThemeColor = ThemeColor.none
    var name: String = ""
    var source: Source = Source.tasks
//    let filters: [String : PartialKeyPath<aChart>] = ["Test" : \aChart.name]
    let size: Size = Size.half
    var style: Style = Style.column
    var rollupStyle: RollupCalculation?
    var dashboard: Dashboard?
    var statusSection: StatusSection?
    
    init(
        color: ThemeColor = ThemeColor.none,
        name: String,
        source: aChart.Source = Source.tasks,
        style: aChart.Style = Style.column,
        rollupStyle: RollupCalculation? = nil
    ) {
        self.name = name
        self.color = color
        self.source = source
        self.style = style
        self.rollupStyle = rollupStyle
    }
}

extension aChart {
    enum Size: String, CaseIterable, Codable {
        case half = "Half size"
        case full = "Full size"
        
        var columns: Int {
            switch self {
            case .half:
                2
            case .full:
                4
            }
        }
        
        var compactColumns: Int {
            switch self {
            case .half:
                1
            case .full:
                2
            }
        }
    }
    
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

extension aChart {
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
