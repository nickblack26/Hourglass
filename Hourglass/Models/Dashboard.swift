import Foundation
import SwiftData

@Model
final class Dashboard {
    var name: String = ""
    var notes: String?
    var icon: Icon = Icon.report
	var color: ThemeColor = ThemeColor.none
    var starred: Bool = false
	
	@Relationship(inverse: \Project.dashboard)
    var project: Project?
    
    init(
        name: String,
        notes: String? = nil,
        icon: Icon = Icon.report,
        color: ThemeColor = ThemeColor.allCases.randomElement() ?? .aqua
    ) {
        self.name = name
        self.notes = notes
        self.icon = icon
        self.color = color
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

