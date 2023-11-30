//
//  MyTasksViewModel.swift
//  Asana Clone
//
//  Created by Nick on 6/26/23.
//

import Foundation
import Observation

@Observable class MyTasksViewModel {
	var recentTasks: [PublicTasksModel] = []
	var todaysTasks: [PublicTasksModel] = []
	var nextTasks: [PublicTasksModel] = []
	var laterTasks: [PublicTasksModel] = []
	private let manager = SupabaseManger.shared
	
	init() {
		getTasks()
	}
	
	func getTasks() {
		Task {
			self.recentTasks = await manager.getTasks()
		}
	}
}
