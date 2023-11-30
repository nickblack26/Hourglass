//
//  WidgetOptionModel.swift
//  Asana Clone
//
//  Created by Nick on 6/27/23.
//

import Foundation
import CoreTransferable
let manager = SupabaseManger.shared

struct WidgetOptionModel: Identifiable, Codable, Hashable {
	var id: UUID
	var name: String
	var image: String
	var columns: Int
	
	init(name: String, image: String, columns: Int = 1) {
		self.id = UUID()
		self.name = name
		self.image = image
		self.columns = columns
	}
}

extension WidgetOptionModel: Transferable {
	static var transferRepresentation: some TransferRepresentation {
		CodableRepresentation(contentType: .data)
	}
}

let myTasks: WidgetOptionModel = .init(name: "My Tasks", image: "myTasksWidgetPreview")

let people: WidgetOptionModel = .init(name: "People", image: "peopleWidgetPreview",  columns: 2)

let projects: WidgetOptionModel = .init(name: "Projects", image: "projectsWidgetPreview")

let notepad: WidgetOptionModel = .init(name: "Private notepad", image: "notepadWidgetPreview")

let tasksAssigned: WidgetOptionModel = .init(name: "Tasks I've assigned", image: "assignedTasksWidgetPreview")

let draftComments: WidgetOptionModel = .init(name: "Draft comments", image: "draftedCommentsWidgetPreview")

let forms: WidgetOptionModel = .init(name: "Forms", image: "formsWidgetPreview")

let myGoals: WidgetOptionModel = .init(name: "My goals", image: "myGoalsWidgetPreview")


let allWidgets: [WidgetOptionModel] = [
	myTasks,
	people,
	projects,
	notepad,
	tasksAssigned,
	draftComments,
	forms,
	myGoals
]

let defaultWidgets: [WidgetOptionModel] = [
	myTasks,
	projects,
	tasksAssigned,
	myGoals,
	people
]
