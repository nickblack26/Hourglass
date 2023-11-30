//
//  TeamsModels.swift
//  Asana Clone
//
//  Created by Nick on 6/24/23.
//

import Foundation

struct PublicTeamsModel: Identifiable, Codable {
	var id: UUID
	var name: String
	var description: String?
}

struct PublicTeamUsersModel {
	var team_id: PublicTeamsModel
	var user_id: PublicUsersModel
}
