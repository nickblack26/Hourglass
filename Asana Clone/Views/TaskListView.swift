//
//  TaskListView.swift
//  Asana Clone
//
//  Created by Nick on 7/17/23.
//

import SwiftUI

struct TaskListView: View {
	var columns: [String] = ["Task name", "Assignee", "Due date", "Priority", "Status"]
	var sections: [String] = ["To do", "Doing", "Done"]
	var tasks: [PublicTasksModel] = [
		.init(id: UUID(), name: "Draft project brief", is_complete: false),
		.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false),
		.init(id: UUID(), name: "Share timeline with teammates", is_complete: false, subtasks: [
			.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false),
			.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false),
			.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false),
			.init(id: UUID(), name: "Schedule kickoff meeting", is_complete: false)
		]),
	]
	
    var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				VStack(alignment: .leading, spacing: 0) {
					Divider()
					
//					HStack(spacing: 0) {
//						ForEach(columns.indices, id: \.self) { index in
//							if index == 0 {
//								TableDateCellView(width: 500, isFirst: true, text: columns[index], isLast: false, isHeader: true)
//							} else {
//								TableDateCellView(isFirst: true, text: columns[index], isLast: false,  isHeader: true)
//							}
//						}
//						
//						Button {
//							
//						} label: {
//							Image(systemName: "plus")
//						}
//						.padding(.horizontal)
//					}
					
					Divider()
				}
				
				ForEach(sections, id: \.self) { section in
					DisclosureGroup(section) {
						HStack(spacing: 0) {
							ForEach(tasks.indices, id: \.self) { index in
//								TableDateCellView(isFirst: index == 0, text: tasks[index].name, isLast: false , isHeader: false)
							}
							
							Text(" ")
								.padding(.horizontal)
						}
					}
				}
				
				Spacer()
			}
		}
    }
}

#Preview {
    TaskListView()
}
