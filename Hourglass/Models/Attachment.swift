import Foundation
import SwiftData

// MARK: - Attachment
@Model
class Attachment: Hashable {
    var id: UUID
    var resourceType: String?
    var name: String?
    var resourceSubtype: String?
    var connectedToApp: Bool?
    var createdAt: String?
    var downloadUrl: String?
    var host: String?
    var parent: aTask?
    var permanentUrl: String?
    var size: Int?
    var viewUrl: String?

    enum CodingKeys: String, CodingKey {
        case gid = "gid"
        case resourceType = "resource_type"
        case name = "name"
        case resourceSubtype = "resource_subtype"
        case connectedToApp = "connected_to_app"
        case createdAt = "created_at"
        case downloadUrl = "download_url"
        case host = "host"
        case permanentUrl = "permanent_url"
        case size = "size"
        case viewUrl = "view_url"
    }

    init(
        resourceType: String?,
        name: String?,
        resourceSubtype: String?,
        connectedToApp: Bool?,
        createdAt: String?,
        downloadUrl: String?,
        host: String?,
        parent: aTask?,
        permanentUrl: String?,
        size: Int?,
        viewUrl: String?
    ) {
        self.id = UUID()
        self.resourceType = resourceType
        self.name = name
        self.resourceSubtype = resourceSubtype
        self.connectedToApp = connectedToApp
        self.createdAt = createdAt
        self.downloadUrl = downloadUrl
        self.host = host
        self.parent = parent
        self.permanentUrl = permanentUrl
        self.size = size
        self.viewUrl = viewUrl
    }
}
