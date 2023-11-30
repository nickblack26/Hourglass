//
//  UserModels.swift
//  Asana Clone
//
//  Created by Nick on 6/24/23.
//

import Foundation
import GoTrue

struct PublicUsersModel: Identifiable, Codable {
	var id: UUID
	var name: String
	var about: String?
	var profile_image_url: String?
}

struct PublicUserFavorites: Identifiable, Codable {
	var id: UUID
	var user_id: PublicUsersModel?
	var project_id: PublicProjectsModel
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = UUID()
		self.user_id = try container.decodeIfPresent(PublicUsersModel.self, forKey: .user_id)
		self.project_id = try container.decode(PublicProjectsModel.self, forKey: .project_id)
	}
}
