import Foundation
import SwiftData

@Model
final class Timesheet {
    var project: Project?
    var start: Date = Date()
    var end: Date?
    var notes: String?
    var onTheClock: Bool {
        end == nil ? true : false
    }
    
    init(project: Project? = nil, start: Date = Date(), end: Date? = nil, notes: String? = nil) {
        self.project = project
        self.start = start
        self.end = end
        self.notes = notes
    }
}
