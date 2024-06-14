import Foundation
import SwiftData

@Model
final class TimeTrackingEntry {
    var id: UUID
    var createdBy: User?
    var durationMinutes: Int?
    var enteredOn: Date?
    var createdAt: Date?
    var task: aTask?
    
    enum CodingKeys: String, CodingKey {
        case gid = "gid"
        case createdBy = "created_by"
        case durationMinutes = "duration_minutes"
        case enteredOn = "entered_on"
        case createdAt = "created_at"
        case task = "task"
    }
    
    init(
        createdBy: User?,
        durationMinutes: Int?,
        enteredOn: Date?,
        task: aTask?
    ) {
        self.id = .init()
        self.createdBy = createdBy
        self.durationMinutes = durationMinutes
        self.enteredOn = enteredOn
        self.createdAt = .now
        self.task = task
    }
}
