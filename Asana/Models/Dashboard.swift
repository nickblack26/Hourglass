import Foundation
import SwiftData

@Model
final class Dashboard {
    let name: String
    let notes: String?
    let icon: Icon = Icon.report
    let color: AsanaColor
    let starred: Bool = false
    
    @Relationship(deleteRule: .cascade, inverse: \Chart.dashboard)
    let charts: [Chart] = []
    
    init(
        name: String,
        notes: String? = nil,
        icon: Icon = Icon.report,
        color: AsanaColor = AsanaColor.allCases.randomElement() ?? .aqua,
        charts: [Chart] = []
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
    }
}

