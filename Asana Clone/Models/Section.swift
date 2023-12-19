import Foundation
import SwiftData
import CoreTransferable

@Model
class Section {
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
}

//extension SectionModel: Transferable {
//    static var transferRepresentation: some TransferRepresentation {
//        CodableRepresentation(contentType: .data)
//    }
//}


extension [Section] {
    func updateOrderIndices() {
        for (index, item) in enumerated() {
            item.order = index
        }
    }
}
