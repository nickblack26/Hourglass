import Foundation
import SwiftData

@Model
class SectionModel {
    var name: String
    
    var tasks: [TaskModel]
    
    init(name: String, tasks: [TaskModel] = []) {
        self.name = name
        self.tasks = tasks
    }
}
