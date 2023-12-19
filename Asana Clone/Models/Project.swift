import Foundation
import SwiftData
import SwiftUI

@Model
class Project {
    // MARK: Generic variables
    var name: String = ""
    var startDate: Date?
    var endDate: Date?
    var details: String?
    var color: Color = Color.aqua
    var icon: Icon = Icon.calendar
    var defaultTab: Tab = Tab.list
    var privacy: Privacy = Privacy.publicToTeam
    var archived: Bool = false
    var status: Status?
    var starred: Bool = false
    
    // MARK: Inferred relationships
    // These are inferred from setting the relationship on the parent
    // or if the model has just a singular variable
    var owner: Member?
    var team: Team?
    var sections: [Section]?  = []
    
    // MARK: Explicit relationships
    @Relationship(deleteRule: .nullify, inverse: \Task.projects)
    var tasks: [Task]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \Member.projects)
    var members: [Member]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \Comment.projects)
    var comments: [Comment]? = []
    
    init(
        name: String,
        startDate: Date? = nil,
        endDate: Date? = nil,
        details: String? = nil,
        owner: Member,
        team: Team? = nil,
        tasks: [Task] = [],
        members: [Member] = [],
        sections: [Section] = [],
        color: Color = Color.allCases.randomElement() ?? .aqua,
        icon: Icon = Icon.allCases.randomElement() ?? .calendar,
        defaultTab: Tab = .list,
        privacy: Privacy = Privacy.publicToTeam,
        archived: Bool = false,
        status: Status? = nil
    ) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.details = details
        self.owner = owner
        self.team = team
        self.tasks = tasks
        self.members = members
        self.sections = sections
        self.color = color
        self.icon = icon
        self.defaultTab = defaultTab
        self.privacy = privacy
        self.archived = archived
    }
}

extension Project {
    enum Color: CaseIterable, Codable {
        case none
        case red
        case orange
        case yellowOrange
        case yellow
        case yellowGreen
        case green
        case blueGreen
        case aqua
        case blue
        case indigo
        case purple
        case magenta
        case hotPink
        case pink
        case coolGray
        
        var color: SwiftUI.Color {
            switch self {
            case .none: SwiftUI.Color(.gray)
            case .red: SwiftUI.Color(.red)
            case .orange: SwiftUI.Color(.orange)
            case .yellowOrange: SwiftUI.Color(.orange)
            case .yellow: SwiftUI.Color(.yellow)
            case .yellowGreen: SwiftUI.Color(.green)
            case .green: SwiftUI.Color(.green)
            case .blueGreen: SwiftUI.Color(.teal)
            case .aqua: SwiftUI.Color(.teal)
            case .blue: SwiftUI.Color(.blue)
            case .indigo: SwiftUI.Color(.purple)
            case .purple: SwiftUI.Color(.purple)
            case .magenta: SwiftUI.Color(.purple)
            case .hotPink: SwiftUI.Color(.pink)
            case .pink: SwiftUI.Color(.pink)
            case .coolGray: SwiftUI.Color(.darkGray)
            }
        }
    }

    enum Icon: String, CaseIterable, Codable {
        case board
        case bug
        case calendar
        case graph
        case lightBulb
        case list
        case people
        case rocket
        case star
        case timeline
        
        var icon: String {
            switch self {
            case .board:
                "project_\(self.rawValue)_icon"
            case .bug:
                "project_\(self.rawValue)_icon"
            case .calendar:
                "project_\(self.rawValue)_icon"
            case .graph:
                "project_\(self.rawValue)_icon"
            case .lightBulb:
                "project_\(self.rawValue)_icon"
            case .list:
                "project_\(self.rawValue)_icon"
            case .people:
                "project_\(self.rawValue)_icon"
            case .rocket:
                "project_\(self.rawValue)_icon"
            case .star:
                "project_\(self.rawValue)_icon"
            case .timeline:
                "project_\(self.rawValue)_icon"
            }
        }
    }

    enum Privacy: String, CaseIterable, Codable {
        case publicToTeam = "Public to Engineering"
        case publicToMembers = "Public to project members"
        case privateToMe = "Private to me"
        
        var privacyBool: Bool {
            switch self {
                case .publicToTeam:
                    return true
                default:
                    return false
            }
        }
    }

    enum Tab: String, CaseIterable, Codable {
        case overview = "Overview"
        case list = "List"
        case board = "Board"
        case timeline = "Timeline"
        case calendar = "Calendar"
        case workflow = "Workflow"
        case dashboard = "Dashboard"
        case messages = "Messages"
        case files = "Files"
        
        var showMenu: Bool {
            switch self {
                case .overview:
                    return false
                case .list:
                    return true
                case .board:
                    return true
                case .timeline:
                    return true
                case .calendar:
                    return true
                case .workflow:
                    return false
                case .dashboard:
                    return false
                case .messages:
                    return false
                case .files:
                    return false
            }
        }
        
        var image: String {
            switch self {
                case .list: return "newProjectList"
                case .board: return "newProjectBoard"
                case .timeline: return "newProjectTimeline"
                case .calendar: return "newProjectCalendar"
                default: return ""
            }
        }
    }

    enum Status: String, CaseIterable, Codable {
        case onTrack = "On track"
        case atRisk = "At risk"
        case offTrack = "Off track"
        case onHold = "On hold"
        case complete = "Complete"
        
        var color: Color {
            switch self {
            case .onTrack:
                    .green
            case .atRisk:
                    .yellow
            case .offTrack:
                    .red
            case .onHold:
                    .blue
            case .complete:
                    .green
            }
        }
    }

    enum FirstStep: String, CaseIterable {
        case tasks
        case share
        case workflow
        
        var details: (String, String, String) {
            switch self {
                case .tasks: return ("addTasksIcon", "Start adding tasks", "Assign, set due dates, and get to work")
                case .share: return ("shareIcon", "Start adding tasks", "Assign, set due dates, and get to work")
                case .workflow: return ("workflowIcon", "Start adding tasks", "Assign, set due dates, and get to work")
            }
        }
    }
}
