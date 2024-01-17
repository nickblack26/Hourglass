import Foundation
import SwiftData

@Model
final class Dashboard {
    var name: String
    var notes: String?
    var icon: Icon = Icon.report
    var color: AsanaColor
    var starred: Bool = false
    var project: Project?
    
    @Relationship(deleteRule: .cascade, inverse: \aChart.dashboard)
    var charts: [aChart] = []
    
    init(
        name: String,
        notes: String? = nil,
        icon: Icon = Icon.report,
        color: AsanaColor = AsanaColor.allCases.randomElement() ?? .aqua,
        charts: [aChart] = []
    ) {
        self.name = name
        self.notes = notes
        self.icon = icon
        self.color = color
        self.charts = charts
    }
}

extension Dashboard {
    enum Icon: String, CaseIterable, Codable {
        case report, brain, satellite, crystalBall, glasses, temperature, health, balance
        
        var image: String {
            switch self {
            case .report:
                ""
            case .brain:
                ""
            case .satellite:
                ""
            case .crystalBall:
                ""
            case .glasses:
                ""
            case .temperature:
                ""
            case .health:
                ""
            case .balance:
                ""
            }
        }
    }
}

