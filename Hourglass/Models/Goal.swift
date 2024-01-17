import Foundation
import SwiftData

@Model
final class Goal {
    var name : String = ""
    var liked: Bool = false
    var dueOn: Date?
    var htmlNotes: Data?
    var notes : String?
    var startOn : Date?
    var status : StatusType?
    var numLikes : Int?
	
	@Relationship(inverse: \StatusUpdate.goal)
    var currentStatusUpdate: StatusUpdate?

    init(
        name: String,
        dueOn: Date? = nil,
        htmlNotes: Data? = nil,
        notes: String? = nil,
        startOn: Date? = nil,
        status: StatusType? = nil,
        num_likes: Int? = nil
    ) {
        self.name = name
        self.dueOn = dueOn
        self.htmlNotes = htmlNotes
        self.notes = notes
        self.startOn = startOn
        self.status = status
        self.numLikes = numLikes
    }
}
