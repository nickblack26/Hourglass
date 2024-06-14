import Foundation
import SwiftData

// MARK: - Options
@Model
class Options {
    var showPayMeButton: Bool?
    var groupBy: Int?
    var locale: String?
    var language: String?
    var projectName: String?
    var label: String?

    init(showPayMeButton: Bool?, groupBy: Int?, locale: String?, language: String?, projectName: String?, label: String?) {
        self.showPayMeButton = showPayMeButton
        self.groupBy = groupBy
        self.locale = locale
        self.language = language
        self.projectName = projectName
        self.label = label
    }
}
