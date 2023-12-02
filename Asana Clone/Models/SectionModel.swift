import Foundation

struct SectionTask: Hashable {
	var section: SectionModel
	var task: PublicTasksModel
}

extension SectionTask: Decodable {
	enum CodingKeys: String, CodingKey {
		case section
		case task
	}
}

struct SectionModel: Identifiable {
	var id: UUID
	var name: String
	var project: PublicProjectsModel?
	var isDefault: Bool
	var user: PublicUsersModel?
	var order: Int
	var tasks: [SectionTask]
}

extension SectionModel: Hashable {
	static func == (lhs: SectionModel, rhs: SectionModel) -> Bool {
		lhs.id == rhs.id
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(name)
	}
}

extension SectionModel: Decodable {
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case project = "project_id"
		case isDefault = "is_default"
		case user = "user_id"
		case order
		case tasks = "section_tasks"
	}
}
