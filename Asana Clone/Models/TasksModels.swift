import Foundation
import CoreTransferable

struct PublicTasksModel: Identifiable, Codable, Hashable {
	var id: UUID
	var name: String
	var is_complete: Bool
	var description: String?
	var start_date: Date?
	var end_date: Date?
	var user_id: PublicUsersModel?
	var created_at: Date?
	var subtasks: [PublicTasksModel]?
	var sections: [PublicProjectSectionModel]?
	
	init(
		id: UUID,
		name: String,
		is_complete: Bool,
	 	description: String? = nil,
	 	start_date: Date? = nil,
	 	end_date: Date? = nil,
	 	user_id: PublicUsersModel? = nil,
	 	created_at: Date? = nil,
	 	subtasks: [PublicTasksModel]? = nil,
		sections: [PublicProjectSectionModel]? = nil
	) {
		self.id = id
		self.name = name
		self.is_complete = is_complete
		self.description = description
		self.start_date = start_date
		self.end_date = end_date
		self.user_id = user_id
		self.created_at = created_at
		self.subtasks = subtasks
		self.sections = sections
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		self.id = try container.decode(UUID.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
		self.is_complete = try container.decode(Bool.self, forKey: .is_complete)
		self.description = try container.decodeIfPresent(String.self, forKey: .description)
		self.start_date = dateFormatter.date(from: try container.decodeIfPresent(String.self, forKey: .start_date) ?? "")
		self.end_date = dateFormatter.date(from: try container.decodeIfPresent(String.self, forKey: .end_date) ?? "")
		self.user_id = try container.decodeIfPresent(PublicUsersModel.self, forKey: .user_id)
		self.created_at = dateFormatter.date(from: try container.decodeIfPresent(String.self, forKey: .created_at) ?? "")
		self.subtasks = try container.decodeIfPresent([PublicTasksModel].self, forKey: .subtasks)
		self.sections = try container.decodeIfPresent([PublicProjectSectionModel].self, forKey: .sections)
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(name)
		hasher.combine(is_complete)
	}
	
	static func == (lhs: PublicTasksModel, rhs: PublicTasksModel) -> Bool {
		return lhs.id == rhs.id && lhs.name == rhs.name && rhs.is_complete == lhs.is_complete
	}
}

extension PublicTasksModel: Transferable {
	static var transferRepresentation: some TransferRepresentation {
		CodableRepresentation(contentType: .data)
	}
}

struct PublicTaskCollaborators: Codable {
	var task_id: PublicTasksModel
	var user_id: PublicUsersModel
}
