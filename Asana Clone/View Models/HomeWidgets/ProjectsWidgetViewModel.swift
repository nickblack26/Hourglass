//
//  ProjectsWidgetViewModel.swift
//  Asana Clone
//
//  Created by Nick on 6/30/23.
//

import Foundation
import Observation

@Observable
class ProjectsWidgetViewModel {
	var projects: [PublicProjectsModel] = []
	@ObservationIgnored var manager = SupabaseManger.shared
	
	init() {
		Task {
			self.projects = await manager.getProjects()
		}
	}
}
