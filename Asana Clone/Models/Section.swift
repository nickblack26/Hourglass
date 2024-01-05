import Foundation
import SwiftData
import CoreTransferable

@Model
class Section: Codable {
    // MARK: Generic variables
    var name: String = ""
    var order: Int = 0
    var createdAt: Date = Date()
    
    // MARK: Inferred relationships
    var project: Project?
    var member: Member?
    var tasks: [Task]?  = []
    
    init(
        name: String,
        order: Int,
        project: Project? = nil,
        member: Member? = nil,
        tasks: [Task] = []
    ) {
        self.name = name
        self.order = order
        self.project = project
        self.member = member
        self.tasks = tasks
        self.createdAt = Date()
    }
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
    }
    
    func encode(to encoder: Encoder) throws {
        let container = encoder.container(keyedBy: CodingKeys.self)
        
    }
}

extension Section: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .data)
    }
}


extension [Section] {
    func updateOrderIndices() {
        for (index, item) in enumerated() {
            item.order = index
        }
    }
}
