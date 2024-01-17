import Foundation
import SwiftData

@Model
final class StatusSection {
    var name: String = ""
    var htmlText: Data?
    var order: Int = 0
    var statusUpdate: StatusUpdate?
    
    @Relationship(deleteRule: .cascade, inverse: \aChart.statusSection)
    var charts: [aChart]? = []
    
    init(name: String, htmlText: Data? = nil, order: Int = 0) {
        self.name = name
        self.htmlText = htmlText
        self.order = order
    }
}
