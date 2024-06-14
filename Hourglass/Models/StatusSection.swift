import Foundation
import SwiftData

@Model
final class StatusSection {
    var id: UUID
    var name: String = ""
    var htmlText: Data?
    var order: Int = 0
    var statusUpdate: StatusUpdate?

    
    init(name: String, htmlText: Data? = nil, order: Int = 0) {
        self.id = .init()
        self.name = name
        self.htmlText = htmlText
        self.order = order
    }
}
