import Foundation
import SwiftUI
import Observation

@Observable class AsanaManager {
    var selectedTask: Task?
    var draggingTask: Task?
    var draggingSection: Section?
    var draggingWidget: Widget?
    var currentTeam: Team?
    var currentMember: Member?
    var selectedLink: SidebarLink? = .home
    var showHomeCustomization: Bool = false
    var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
}
