//
//  ProjectViewModel.swift
//  Asana Clone
//
//  Created by Nick on 7/6/23.
//

import Foundation
import Observation

@Observable
class ProjectViewModel {
	var project: PublicProjectsModel? = nil
	private let manager = SupabaseManger.shared
	
	init(id: UUID) {
		getProjectInfo(id: id)
	}
	
	func getProjectInfo(id: UUID) {
		Task {
			self.project = try await manager.getProject(id: id)
		}
	}
}
