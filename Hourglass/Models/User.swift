import Foundation
import SwiftData

@Model
final class User: Hashable {
    var id: UUID
    var email: String?
    var name: String
    var photo: [String:String]?
    
//    MARK: Object Relationships
    var workspaces: [Workspace]?

    init(
        email: String?,
        name: String,
        photo: [String:String]?,
        workspaces: [Workspace]?
    ) {
        self.id = .init()
        self.email = email
        self.name = name
        self.photo = photo
        self.workspaces = workspaces
    }
}
