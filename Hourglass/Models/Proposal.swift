//
//  Proposal.swift
//  Hourglass
//
//  Created by Nick Black on 6/13/24.
//

import Foundation
import SwiftData

@Model
final class Proposal {
    var id: UUID
    var status: Status
    var proposalType: Proposal.`Type`
    
    @Relationship(deleteRule: .cascade, inverse: \Module.proposal)
    var modules: [Module]?

    init(status: Status = .draft, modules: [Module]?, proposalType: Proposal.`Type`) {
        self.id = .init()
        self.status = status
        self.modules = modules
        self.proposalType = proposalType
    }
    
    enum Status: String, CaseIterable, Codable {
        case approved, sent, viewed, draft, dismissed
    }
    
    enum `Type`: String, CaseIterable, Codable {
        case proposal, proposalAndContract
    }
}

// MARK: - Module
@Model
final class Module {
    var moduleType: Module.`Type`
    var title: String?
    var text: String?
    var proposal: Proposal?

    init(
        moduleType: Module.`Type` = .text,
        title: String?,
        text: String?
    ) {
        self.moduleType = moduleType
        self.title = title
        self.text = text
    }
    
    enum `Type`: String, CaseIterable, Codable {
        case text, image, table, columns, file
    }
}

final class Term {
    var id: UUID
    var serviceType: ServiceType
    var rateType: RateType
    var name: String
    var description: String?
    var quantity: Int
    var rate: Int
    var billTrackedHours: Bool?
    var position: Int

    init(
        serviceType: ServiceType = .flatFee,
        rateType: RateType,
        name: String,
        description: String?,
        quantity: Int = 1,
        rate: Int,
        billTrackedHours: Bool = true,
        position: Int = 0
    ) {
        self.id = .init()
        self.serviceType = serviceType
        self.rateType = rateType
        self.name = name
        self.description = description
        self.quantity = quantity
        self.rate = rate
        self.billTrackedHours = billTrackedHours
        self.position = position
    }
    
    enum RateType: String, CaseIterable, Codable {
        case flatFee = "Flat Fee"
        case perHour = "Per Hour"
        case perDay = "Per Day"
        case perItem = "Per Item"
        case perWord = "Per Word"
        case custom = "Custom"
    }
    
    enum ServiceType: String, CaseIterable, Codable {
        case flatFee = "Flat Fee"
        case perHour = "Per Hour"
        case perDay = "Per Day"
        case perItem = "Per Item"
        case perWord = "Per Word"
        case custom = "Custom"
    }
}
