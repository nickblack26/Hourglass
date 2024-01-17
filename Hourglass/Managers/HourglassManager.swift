import Foundation
import SwiftUI
import Observation

@Observable 
class HourglassManager {
    var newClient: Bool = false
    var selectedTask: aTask?
    var selectedTransaction: Transaction?
    var draggingTask: aTask?
    var draggingSection: aSection?
    var draggingWidget: Widget?
    var selectedCustomField: CustomField?
    var selectedChart: aChart?
    var selectedDashboard: Dashboard?
    var selectedLink: SidebarLink? = .home
    var path: [SidebarLink] = []
    var showHomeCustomization: Bool = false
    var newDashboard: Bool = false
    var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    var currentTimesheet: Timesheet?
    var availableWidgets: [Widget] {
        allWidgets.filter {
            return allWidgets.contains($0)
        }
    }
}

enum ThemeColor: CaseIterable, Codable {
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
    
    var color: Color {
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

enum SidebarLink: Hashable {
    case home
    case myTasks
    case inbox
    case transactions
    case reporting
    case portfolios
    case goals
    case project(Project)
    case client(Client)
}
