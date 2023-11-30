//
//  TaskBoardView.swift
//  Asana Clone
//
//  Created by Nick on 7/20/23.
//

import SwiftUI

struct TaskBoardView: View {
	@Environment(SupabaseManger.self) private var manager
	@State private var currentlyDraggingTask: PublicTasksModel?
	@State private var currentlyDraggingSection: PublicProjectSectionModel?
	@State private var updatedSections: [PublicProjectSectionModel] = []
	var sections: [PublicProjectSectionModel]
	
	init(sections: [PublicProjectSectionModel] = []) {
		self.currentlyDraggingTask = nil
		self.currentlyDraggingSection = nil
		self._updatedSections = State(initialValue: sections)
		self.sections = sections
	}
	
	var body: some View {
		ScrollView(.horizontal) {
			HStack(alignment: .top, spacing: 25) {
				if !sections.isEmpty {
					ForEach(updatedSections) { section in
						VStack(spacing: 15) {
							Section {
								VStack(alignment: .leading) {
									ScrollView(.vertical) {
										VStack {
											if let tasks = section.section_tasks {
												ForEach(tasks, id: \.task.id) { task in
													TaskCardView(currentlyDragging: $currentlyDraggingTask, currentlyDraggingSection: $currentlyDraggingSection, task: task.task, section: section)
														.dropDestination(for: PublicTasksModel.self) { items, location in
															currentlyDraggingTask = nil
															currentlyDraggingSection = nil
															return false
														} isTargeted: { status in
															if let currentlyDraggingTask, status, currentlyDraggingTask.id != task.task.id {
																withAnimation(.snappy) {
																	//															replaceItems(items: &tasks, droppingTask: currentlyDragging, section: section, droppingSection: section)
																}
															}
														}
												}
											}
											
											HStack {
												Spacer()
												
												Button {
													
												} label: {
													Label("Add task", systemImage: "plus")
														.font(.caption)
														.foregroundStyle(.secondary)
														.padding()
												}
												.buttonStyle(.plain)
												
												Spacer()
											}
											
										}
									}
								}
								.background {
									LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.05), .clear]), startPoint: .top, endPoint: .bottom)
								}
								.frame(maxHeight: .infinity, alignment: .top)
							} header: {
								HStack {
									Text(section.name)
									
									Spacer()
									
									Button {
										addTask(section)
									} label: {
										Image(systemName: "plus")
									}
									
									Button {
										
									} label: {
										Image(systemName: "ellipsis")
									}
								}
							}
						}
						.frame(minWidth: 200)
					}
				}
				
				Section {
					VStack(alignment: .leading) {
						Spacer()
					}
					.background {
						LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.05), .clear]), startPoint: .top, endPoint: .bottom)
					}
					.frame(maxHeight: .infinity, alignment: .top)
				} header: {
					Button {
						addSection()
					} label: {
						Label("Add section", systemImage: "plus")
					}
					.buttonStyle(.plain)
					.foregroundStyle(.secondary)
				}
			}
		}
		.frame(maxHeight: .infinity, alignment: .top)
	}
	
	mutating func addSection() {
		withAnimation(.smooth) {
			sections.append(.init(id: UUID(), name: "Newest Section"))
			updatedSections.append(.init(id: UUID(), name: "Newest Section"))
			print(updatedSections)
		}
	}
	
	func addTask(_ section: PublicProjectSectionModel) {
		if let section_tasks = section.section_tasks {
			let task: PublicTasksModel = .init(id: UUID(), name: "Testing", is_complete: false)
			let section_task: PublicProjectTaskModel = .init(project_id: <#T##PublicProjectsModel?#>, task: <#T##PublicTasksModel#>, section_id: <#T##PublicProjectSectionModel?#>)
//			section_tasks.append(.init(project_id: .init(id: UUID(), name: "Project"), task: task, section_id: section))
		}
	}
	
	func appendTask(_ section: PublicProjectSectionModel, droppingTask: PublicTasksModel) {
		if let currentlyDraggingTask, let currentlyDraggingSection {
			if let sectionIndex = currentlyDraggingTask.sections?.firstIndex(where: { $0.id == currentlyDraggingSection.id }) {
				var updatedTask = currentlyDraggingTask
				updatedTask.sections?.remove(at: sectionIndex)
				updatedTask.sections?.insert(section, at: sectionIndex)
				
				var updatedSection = currentlyDraggingSection
				//				updatedSection.tasks?.removeAll(where: { $0.id == updatedTask.id })
				
			}
		}
	}
	
	func replaceItems(items: inout [PublicTasksModel], droppingTask: PublicTasksModel, section: PublicProjectSectionModel) {
		if let currentlyDraggingTask {
			if let sourceIndex = items.firstIndex(where: { $0.id == currentlyDraggingTask.id }),
			   let destinationIndex = items.firstIndex(where: { $0.id == droppingTask.id }) {
				var sourceItem = items.remove(at: sourceIndex)
				items.insert(sourceItem, at: destinationIndex)
			}
		}
	}
}

#Preview {
	TaskBoardView(sections: [
		.init(id: UUID(), name: "Untitled Section"),
		.init(id: UUID(), name: "First Section"),
	]).environment(testManager)
}
