//
//  TasksModels.swift
//  Asana Clone
//
//  Created by Nick on 6/24/23.
//

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
