//
//  Tag.swift
//  Hourglass
//
//  Created by Nick Black on 6/11/24.
//

import Foundation
import SwiftData

@Model
final class Tag {
    var id: UUID
    var color: String?
    var createdAt: String?
    var followers: [Workspace]?
    var name: String?
    var notes: String?
    var permalinkUrl: String?
    var workspace: Workspace?

    init(
        color: String?,
        createdAt: String?,
        followers: [Workspace]?,
        name: String?,
        notes: String?,
        permalinkUrl: String?,
        workspace: Workspace?
    ) {
        self.id = .init()
        self.color = color
        self.createdAt = createdAt
        self.followers = followers
        self.name = name
        self.notes = notes
        self.permalinkUrl = permalinkUrl
        self.workspace = workspace
    }
}
