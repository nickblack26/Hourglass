//
//  TimePeriod.swift
//  Hourglass
//
//  Created by Nick Black on 6/11/24.
//

import Foundation
import SwiftData

@Model
final class TimePeriod {
    var id: UUID
    var displayName: String?
    var endOn: Date?
    var parent: TimePeriod?
    var period: Period?
    var startOn: Date?

    init(
        displayName: String? = nil,
        endOn: Date? = nil,
        parent: TimePeriod? = nil,
        period: Period? = nil,
        startOn: Date? = nil
    ) {
        self.id = .init()
        self.displayName = displayName
        self.endOn = endOn
        self.parent = parent
        self.period = period
        self.startOn = startOn
    }
}

extension TimePeriod {
    enum Period: String, CaseIterable, Codable {
        case fy, h1, h2, q1, q2, q3, q4
    }
}
