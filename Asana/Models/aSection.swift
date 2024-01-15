import Foundation
import SwiftData
import CoreTransferable

@Model
class aSection: Codable {
    // MARK: Generic variables
    var name: String = ""
    var order: Int = 0
    var createdAt: Date = Date()
    
    // MARK: Inferred relationships
    var project: Project?
    var tasks: [aTask]?  = []
    
    init(
        name: String,
        order: Int,
        project: Project? = nil,
        tasks: [aTask] = []
    ) {
        self.name = name
        self.order = order
        self.project = project
        self.tasks = tasks
        self.createdAt = Date()
    }
    
    
    init() {
        self.name = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case name, order
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        order = try container.decode(Int.self, forKey: .order)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

extension aSection: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .data)
    }
}

extension [aSection] {
    func updateOrderIndices() {
        for (index, item) in enumerated() {
            item.order = index
        }
    }
}
