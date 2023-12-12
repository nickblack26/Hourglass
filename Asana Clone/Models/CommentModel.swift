//
//  CommentModel.swift
//  Asana Clone
//
//  Created by Nick Black on 12/11/23.
//

import Foundation
import SwiftData

@Model
class CommentModel {
    // MARK: Generic variables
    var message: String
    var subject: String?
    var sentAt: Date?
    var createdAt: Date
    var status: CommentStatus {
        didSet {
            if status == .Sent {
                sentAt = Date()
            }
        }
    }
    
    // MARK: Inferred relationships
    var sender: MemberModel? // set on member model
    var task: TaskModel? // set on task model
    var projects: [ProjectModel]? // set on project model
    var teams: [TeamModel]? // set on team model
    var members: [MemberModel]? // set on member model
    
    init(
        subject: String? = nil,
        message: String,
        sender: MemberModel,
        members: [MemberModel] = [],
        projects: [ProjectModel] = [],
        teams: [TeamModel] = [],
        status: CommentStatus = .Draft
    ) {
        self.subject = subject
        self.message = message
        self.sender = sender
        self.members = members
        self.projects = projects
        self.teams = teams
        self.sentAt = nil
        self.createdAt = Date()
        self.status = status
    }
}

enum CommentStatus: Codable {
    case Draft
    case Sent
}
