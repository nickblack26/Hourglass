import Foundation
import SwiftData
import CoreTransferable

@Model
final class aTask: Hashable, Codable {
    // MARK: Generic variables
    var name: String = ""
    var isCompleted: Bool = false
    var order: Int = 0
    var details: String?
    var startDate: Date?
    var endDate: Date?
    var createdAt: Date = Date()
    var completedAt: Date?
    var taskType: TaskType = TaskType.task
    var taskTypeId: String {
        taskType.rawValue
    }
    
    // MARK: Inferred relationships
    // Relationships inferred from parent
    var parentTask: aTask?
    var section: aSection?
   
    // MARK: Explicit relationships
    @Relationship(deleteRule: .cascade, inverse: \Comment.task)
    var comments: [Comment]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \aTask.parentTask)
    var subtasks: [aTask]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \CustomField.task)
    var customFields: [CustomField]? = []
    
    init(
        name: String,
        isCompleted: Bool = false,
        order: Int,
        details: String? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        createdAt: Date = Date(),
        completedAt: Date? = nil,
        parentTask: aTask? = nil,
        taskType: TaskType = TaskType.task,
        section: aSection? = nil,
        comments: [Comment] = [],
        subtasks: [aTask] = []
    ) {
        self.name = name
        self.isCompleted = isCompleted
        self.order = order
        self.details = details
        self.startDate = startDate
        self.endDate = endDate
        self.createdAt = createdAt
        self.completedAt = completedAt
        self.parentTask = parentTask
        self.taskType = taskType
        self.section = section
        self.comments = comments
        self.subtasks = subtasks
    }
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let _ = try decoder.container(keyedBy: CodingKeys.self)
        
    }
    
    func encode(to encoder: Encoder) throws {
        let _ = encoder.container(keyedBy: CodingKeys.self)
        
    }
}

let currentDate = Date()
let calendar = Calendar.current
let currentWeek = calendar.dateInterval(of: .weekOfYear, for: currentDate)!
let nextWeekDay = calendar.date(byAdding: .day, value: 7, to: currentDate)!
let nextWeek = calendar.dateInterval(of: .weekOfYear, for: nextWeekDay)!

extension aTask {
    enum TaskType: String, Codable {
        case task = "Task"
        case approval = "Approval"
        case milestone = "Milestone"
    }
	
	enum Filter: String, CaseIterable, Codable {
		case incomplete
		case complete
		case dueThisWeek
		case dueNextWeek
		
		var predicate: Predicate<aTask> {
			switch self {
				case .incomplete:
					#Predicate<aTask> { !$0.isCompleted }
				case .complete:
					#Predicate<aTask> { $0.isCompleted }
				case .dueThisWeek:
					#Predicate<aTask> { !$0.isCompleted && $0.endDate != nil && ($0.endDate! >= currentWeek.start || $0.endDate! <= currentWeek.end ) }
				case .dueNextWeek:
					#Predicate<aTask> { !$0.isCompleted && $0.endDate != nil && ($0.endDate! >= nextWeek.start || $0.endDate! <= nextWeek.end ) }
			}
		}
	}
}

extension aTask: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .data)
    }
}

// Helper function
extension aTask {
	func filteredData(filter: aTask.Filter) -> Bool {
//		self
		false
	}
}
//extension Collection where Element: Orderable {
//    mutating func updateOrderIndices() {
//        for (index, item) in enumerated() {
////            self[index].order = item.order
//            item.order = index
//        }
//    }
//}

protocol Orderable {
    var order: Int { get set }
}


/*
 The goal of this function is to pass in an array of keypaths and desired outputs
 Will return if all of the keypaths match the desired outputs
*/
func matchedPredicates<T: Equatable, K: Equatable>(
	obj: T,
	predicates: [(KeyPath<T, Any>, Any)]
) -> Bool where T.Type == K.Type {
	let matches = false
	for (keyPath, value) in predicates {
		if let key = obj[keyPath: keyPath] {
			return false
		}
	}
	return true
}

func processValue<T: Equatable>(of object: T, at keyPath: KeyPath<T, Any>) {
	// Access the value using key path subscripting
	let value = object[keyPath: keyPath]
	
	
	// Perform operations with the value
	print("Value:", value)
}

//func desiredOutputsMatch<T>(object: T, desiredOutputs: [(KeyPath<T, Any>, Any)]) where Any == Comparable -> Bool {
//	for (keyPath, desiredValue) in desiredOutputs {
//		let currentValue = object[keyPath: keyPath]
//		if currentValue != desiredValue {
//			return false
//		}
//	}
//	return true
//}
