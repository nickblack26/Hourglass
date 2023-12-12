//
//  WidgetModel.swift
//  Asana Clone
//
//  Created by Nick on 6/27/23.
//

import Foundation
import SwiftData
import CoreTransferable

enum WidgetType: Codable {
    case myTasks
    case people
    case projects
    case notepad
    case tasksAssigned
    case draftComments
    case forms
    case myGoals
}

@Model
class WidgetModel: Hashable {
	var name: String
	var image: String
	var columns: Int
    var type: WidgetType
	
	init(name: String, image: String, columns: Int = 1, type: WidgetType) {
		self.name = name
		self.image = image
		self.columns = columns
        self.type = type
	}
}

//extension WidgetModel: Transferable {
//	static var transferRepresentation: some TransferRepresentation {
//		CodableRepresentation(contentType: .data)
//	}
//}
