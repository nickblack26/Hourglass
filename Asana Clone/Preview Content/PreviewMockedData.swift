//
//  PreviewMockedData.swift
//  Asana Clone
//
//  Created by Nick Black on 12/1/23.
//

import Foundation

extension PublicProjectsModel {
	static var preview = PublicProjectsModel(id: UUID(), name: "Hourglass")
}

extension PublicUsersModel {
	static var preview = PublicUsersModel(id: UUID(), name: "Hourglass")
}

extension PublicTasksModel {
	static var preview: [PublicTasksModel] = [
		.init(id: UUID(), name: "Draft project brief", is_complete: false),
		.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false),
		.init(id: UUID(), name: "Share timeline with teammates", is_complete: false, subtasks: [
			.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false),
			.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false),
			.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false),
			.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false)
		])
	]
}

extension SectionTask {
	static var preview: [SectionTask] = PublicTasksModel.preview.map { task in
		return SectionTask(section: .preview, task: task)
	}
}

extension SectionModel {
	static var preview = SectionModel(
		id: UUID(),
		name: "📬 New tasks",
		project: .preview,
		isDefault: true,
		user: .preview,
		order: 0,
		tasks: 
			PublicTasksModel.preview.map { task in
				return .init(section: .init(id: UUID(), name: "Test", isDefault: false, order: 0, tasks: []), task: task)
			}
			
		
	)
}
