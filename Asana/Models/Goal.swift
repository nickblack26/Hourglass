import Foundation
import SwiftData

@Model
final class Goal {
    let name : String
    let liked: Bool = false
    let due_on: Date?
    let html_notes: Data?
    let notes : String?
    let start_on : Date?
    let status : String?
    let num_likes : Int?

    init(
        name: String,
        due_on: Date? = nil,
        html_notes: Data? = nil,
        notes: String? = nil,
        start_on: Date? = nil,
        status: String? = nil,
        num_likes: Int? = nil
    ) {
        self.name = name
        self.due_on = due_on
        self.html_notes = html_notes
        self.notes = notes
        self.start_on = start_on
        self.status = status
        self.num_likes = num_likes
    }
}
