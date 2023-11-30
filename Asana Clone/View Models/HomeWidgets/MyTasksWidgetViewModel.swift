//
//  MyTasksWidgetViewModel.swift
//  Asana Clone
//
//  Created by Nick on 6/27/23.
//

import Foundation

class MyTasksWidgetViewModel {
	var upcoming: [PublicTasksModel] = []
	var overdue: [PublicTasksModel] = []
	var completed: [PublicTasksModel] = []
	private let manager = SupabaseManger.shared
	
	init() {
		getTasks()
	}
	
	func getTasks() {
		Task {
			self.upcoming = await manager.getTasks()
		}
	}
}
