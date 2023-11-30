//
//  HomeViewModel.swift
//  Asana Clone
//
//  Created by Nick on 6/25/23.
//

import Foundation
import Observation

@Observable class HomeViewModel {
	static let shared = HomeViewModel()
	var tasks: [PublicTasksModel] = []
	var projects: [PublicProjectsModel] = []
	var completedTasks: Int = 0
	var colorScheme: ColorScheme = .white
	private let manager = SupabaseManger.shared
	var homeWidgets: [WidgetOptionModel] = defaultWidgets
	var availableWidgets: [WidgetOptionModel] = []
	var draggingItem: WidgetOptionModel? = nil
	var sourceIndex: Int? = nil
	
	init() {
		let removeSet = Set(defaultWidgets)
		let newArray = allWidgets.filter{ !removeSet.contains($0) }
		self.availableWidgets = newArray
		
		Task {
//			if (homeWidgets.contains(.projects)) {
//				self.projects = await manager.getProjects()
//			}
			
//			if (homeWidgets.contains(.myTasks)) {
//				self.tasks = await manager.getTasks()
//			}
		}
	}
}
