import Foundation
import Observation

@Observable
class AsanaManager {
    var selectedTask: TaskModel?
    var draggingTask: TaskModel?
    var draggingSection: SectionModel?
    var draggingWidget: WidgetModel?
    var currentTeam: TeamModel?
    var currentMember: MemberModel?
    var selectedLink: SidebarLink? = .home
    var showHomeCustomization: Bool = false    
}
