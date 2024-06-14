import Foundation
import SwiftUICore
import SwiftData

@Model
final class Goal {
    var id: UUID
    var dueOn: Date?
    var htmlNotes: String?
    var isWorkspaceLevel: Bool?
    var name: String?
    var notes: String?
    var startOn: Date?
    var status: String?
    var currentStatusUpdate: StatusUpdate?
    var followers: [User]?
    var likes: [User]?
    var metric: Metric?
    var numLikes: Int? {
        guard let likes else { return 0 }
        return likes.count
    }
    var owner: User?
    var team: Team?
    var timePeriod: TimePeriod?
    var workspace: Workspace?

    init(
        dueOn: Date?,
        htmlNotes: String?,
        isWorkspaceLevel: Bool?,
        name: String?,
        notes: String?,
        startOn: Date?,
        status: String?,
        currentStatusUpdate: StatusUpdate?,
        followers: [User]?,
        likes: [User]?,
        metric: Metric?,
        owner: User?,
        team: Team?,
        timePeriod: TimePeriod?,
        workspace: Workspace?
    ) {
        self.id = .init()
        self.dueOn = dueOn
        self.htmlNotes = htmlNotes
        self.isWorkspaceLevel = isWorkspaceLevel
        self.name = name
        self.notes = notes
        self.startOn = startOn
        self.status = status
        self.currentStatusUpdate = currentStatusUpdate
        self.followers = followers
        self.likes = likes
        self.metric = metric
        self.owner = owner
        self.team = team
        self.timePeriod = timePeriod
        self.workspace = workspace
    }
    
    enum Status: String, CaseIterable {
        case onTrack = "On Track"
        case atRisk = "At Risk"
        case offTrack = "Off Track"
        case missed, achieved, partial, dropped
        
        var color: Color {
            switch self {
            case .onTrack:
                .green
            case .atRisk:
                .yellow
            case .offTrack:
                .red
            default:
                .clear
            }
        }
        
        var showWhenOpen: Bool {
            switch self {
            case .onTrack, .atRisk, .offTrack:
                return true
            default:
                return false
            }
        }
    }
}

@Model 
final class Metric {
    var id: UUID
    var currencyCode: String?
    var currentDisplayValue: String
    var currentNumberValue: Double
    var initialNumberValue: Double
    var precision: Int?
    var progressSource: Source?
    var resourceSubtype: String?
    var targetNumberValue: Double
    var unit: String?
    var canManage: Bool?
    var isCustomWeight: Bool? {
        guard let progressSource else { return false }
        let allowedSources: [Source] = [.subgoalProgress, .projectTaskCompletion, .projectMilestoneCompletion, .taskCompletion]
        return allowedSources.contains(progressSource)
    }
    
    init(
        currencyCode: String? = nil,
        currentDisplayValue: String,
        currentNumberValue: Double,
        initialNumberValue: Double,
        precision: Int? = nil,
        progressSource: Source? = nil,
        resourceSubtype: String? = nil,
        targetNumberValue: Double,
        unit: String? = nil,
        canManage: Bool? = nil
    ) {
        self.id = .init()
        self.currencyCode = currencyCode
        self.currentDisplayValue = currentDisplayValue
        self.currentNumberValue = currentNumberValue
        self.initialNumberValue = initialNumberValue
        self.precision = precision
        self.progressSource = progressSource
        self.resourceSubtype = resourceSubtype
        self.targetNumberValue = targetNumberValue
        self.unit = unit
        self.canManage = canManage
    }

    enum Source: String, CaseIterable, Codable {
        case subgoalProgress, projectTaskCompletion, projectMilestoneCompletion, taskCompletion
    }
}
