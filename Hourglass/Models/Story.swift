//
//  Story.swift
//  Hourglass
//
//  Created by Nick Black on 6/11/24.
//

import Foundation
import SwiftData

@Model
final class Story {
    var id: UUID
    var createdAt: Date?
    var htmlText: String?
    var isPinned: Bool?
    var resourceSubtype: String?
    var stickerName: String?
    var text: String?
    var assignee: User?
    var createdBy: User?
    var customField: CustomField?
    var dependency: User?
    var duplicateOf: User?
    var duplicatedFrom: User?
    var follower: User?
    var hearted: Bool?
    var hearts: [User]?
    var isEditable: Bool?
    var isEdited: Bool?
    var liked: Bool?
    var likes: [User]?
    var newApprovalStatus: String?
    var newDateValue: NewDateValue?
    var newDates: NewDateValue?
    var newEnumValue: EnumOption?
    var newMultiEnumValues: [EnumOption]?
    var newName: String?
    var newNumberValue: Int?
    var newPeopleValue: [User]?
    var newResourceSubtype: String?
    var newSection: User?
    var newTextValue: String?
    var numHearts: Int?
    var numLikes: Int?
    var oldApprovalStatus: String?
    var oldDateValue: NewDateValue?
    var oldDates: NewDateValue?
    var oldEnumValue: EnumOption?
    var oldMultiEnumValues: [EnumOption]?
    var oldName: String?
    var oldNumberValue: Int?
    var oldPeopleValue: [User]?
    var oldResourceSubtype: String?
    var oldSection: User?
    var oldTextValue: String?
    var previews: [Preview]?
    var project: User?
    var source: String?
    var story: Story?
    var tag: Tag?
    var target: User?
    var task: User?
    var type: String?

    init(
        createdAt: Date?,
        htmlText: String?,
        isPinned: Bool?,
        resourceSubtype: String?,
        stickerName: String?,
        text: String?,
        assignee: User?,
        createdBy: User?,
        customField: CustomField?,
        dependency: User?,
        duplicateOf: User?,
        duplicatedFrom: User?,
        follower: User?,
        hearted: Bool?,
        hearts: [User]?,
        isEditable: Bool?,
        isEdited: Bool?,
        liked: Bool?,
        likes: [User]?,
        newApprovalStatus: String?,
        newDateValue: NewDateValue?,
        newDates: NewDateValue?,
        newEnumValue: EnumOption?,
        newMultiEnumValues: [EnumOption]?,
        newName: String?,
        newNumberValue: Int?,
        newPeopleValue: [User]?,
        newResourceSubtype: String?,
        newSection: User?,
        newTextValue: String?,
        numHearts: Int?,
        numLikes: Int?,
        oldApprovalStatus: String?,
        oldDateValue: NewDateValue?,
        oldDates: NewDateValue?,
        oldEnumValue: EnumOption?,
        oldMultiEnumValues: [EnumOption]?,
        oldName: String?,
        oldNumberValue: Int?,
        oldPeopleValue: [User]?,
        oldResourceSubtype: String?,
        oldSection: User?,
        oldTextValue: String?,
        previews: [Preview]?,
        project: User?,
        source: String?,
        story: Story?,
        tag: Tag?,
        target: User?,
        task: User?,
        type: String?
    ) {
        self.id = .init()
        self.createdAt = createdAt
        self.htmlText = htmlText
        self.isPinned = isPinned
        self.resourceSubtype = resourceSubtype
        self.stickerName = stickerName
        self.text = text
        self.assignee = assignee
        self.createdBy = createdBy
        self.customField = customField
        self.dependency = dependency
        self.duplicateOf = duplicateOf
        self.duplicatedFrom = duplicatedFrom
        self.follower = follower
        self.hearted = hearted
        self.hearts = hearts
        self.isEditable = isEditable
        self.isEdited = isEdited
        self.liked = liked
        self.likes = likes
        self.newApprovalStatus = newApprovalStatus
        self.newDateValue = newDateValue
        self.newDates = newDates
        self.newEnumValue = newEnumValue
        self.newMultiEnumValues = newMultiEnumValues
        self.newName = newName
        self.newNumberValue = newNumberValue
        self.newPeopleValue = newPeopleValue
        self.newResourceSubtype = newResourceSubtype
        self.newSection = newSection
        self.newTextValue = newTextValue
        self.numHearts = numHearts
        self.numLikes = numLikes
        self.oldApprovalStatus = oldApprovalStatus
        self.oldDateValue = oldDateValue
        self.oldDates = oldDates
        self.oldEnumValue = oldEnumValue
        self.oldMultiEnumValues = oldMultiEnumValues
        self.oldName = oldName
        self.oldNumberValue = oldNumberValue
        self.oldPeopleValue = oldPeopleValue
        self.oldResourceSubtype = oldResourceSubtype
        self.oldSection = oldSection
        self.oldTextValue = oldTextValue
        self.previews = previews
        self.project = project
        self.source = source
        self.story = story
        self.tag = tag
        self.target = target
        self.task = task
        self.type = type
    }
}

@Model
final class DateValue {
    var date: Date?
    var dateTime: Date?

    init(date: Date?, dateTime: Date?) {
        self.date = date
        self.dateTime = dateTime
    }
}

@Model
final class NewDateValue {
    var dueAt: Date?
    var dueOn: Date?
    var startOn: Date?

    init(dueAt: Date?, dueOn: Date?, startOn: Date?) {
        self.dueAt = dueAt
        self.dueOn = dueOn
        self.startOn = startOn
    }
}

@Model
final class Preview {
    var fallback: String?
    var footer: String?
    var header: String?
    var headerLink: String?
    var htmlText: String?
    var text: String?
    var title: String?
    var titleLink: String?

    init(
        fallback: String?,
        footer: String?,
        header: String?,
        headerLink: String?,
        htmlText: String?,
        text: String?,
        title: String?,
        titleLink: String?
    ) {
        self.fallback = fallback
        self.footer = footer
        self.header = header
        self.headerLink = headerLink
        self.htmlText = htmlText
        self.text = text
        self.title = title
        self.titleLink = titleLink
    }
}

