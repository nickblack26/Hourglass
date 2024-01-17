import Foundation
import SwiftData
import SwiftUI
import CoreTransferable
import CloudKit
import SwiftDataKit

@Model
final class Project: Codable {
    // MARK: Generic variables
    var name: String = ""
    var startDate: Date?
    var endDate: Date?
    var details: String?
    var color: AsanaColor = AsanaColor.aqua
    var icon: Icon = Icon.calendar
    var defaultTab: Tab = Tab.list
    var archived: Bool = false
    var status: Status?
    var starred: Bool = false
    var dashboard: Dashboard?
    var client: Client?
    
    @Relationship(deleteRule: .cascade, inverse: \aSection.project)
    var sections: [aSection]?
    
    // MARK: Explicit relationships
    @Relationship(deleteRule: .nullify, inverse: \aTask.projects)
    var tasks: [aTask]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \Comment.projects)
    var comments: [Comment]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \CustomField.project)
    var customFields: [CustomField]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \Transaction.project)
    var transactions: [Transaction] = []
    
    @Relationship(deleteRule: .nullify, inverse: \Timesheet.project)
    var timesheets: [Timesheet] = []
    
    init(
        name: String,
        startDate: Date? = nil,
        endDate: Date? = nil,
        details: String? = nil,
        tasks: [aTask] = [],
        sections: [aSection] = [],
        color: AsanaColor = AsanaColor.allCases.randomElement() ?? .aqua,
        icon: Icon = Icon.allCases.randomElement() ?? .calendar,
        defaultTab: Tab = .list,
        archived: Bool = false,
        status: Status? = nil
    ) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.details = details
        self.tasks = tasks
        self.sections = sections
        self.color = color
        self.icon = icon
        self.defaultTab = defaultTab
        self.archived = archived
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case sections
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        sections = try container.decodeIfPresent([aSection].self, forKey: .sections)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(sections, forKey: .sections)
    }
}

extension Project: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .data)
    }
}

extension Project {
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
            case .overview: return "list.clipboard"
            case .list: return "checklist.unchecked"
            case .board: return "rectangle.split.3x1"
            case .timeline: return "timeline.selection"
            case .calendar: return "calendar"
            case .workflow: return "point.3.connected.trianglepath.dotted"
            case .dashboard: return "chart.xyaxis.line"
            case .messages: return "message"
            case .files: return "paperclip"
            }
        }
    }
    
    enum Status: String, CaseIterable, Codable {
        case onTrack = "On track"
        case atRisk = "At risk"
        case offTrack = "Off track"
        case onHold = "On hold"
        case complete = "Complete"
        
        var color: AsanaColor {
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

// MARK: HELPER FUNCTIONS
extension Project {
    func addCustomField() {
        guard let sections = sections else { return }
        for section in sections {
            if let tasks = section.tasks {
                for task in tasks {
                    task.customFields = customFields
                }
            }
        }
    }
    
    func createCloudKitRecord() -> CKRecord {
        
        //        let project = CKRecord(recordType: "projects", recordID: self.persistentModelID.id)
        return CKRecord(recordType: "users")
    }
}
