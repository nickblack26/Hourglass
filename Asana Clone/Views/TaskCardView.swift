//
//  TaskCardView.swift
//  Asana Clone
//
//  Created by Nick on 7/20/23.
//

import SwiftUI

struct TaskCardView: View {
	@State private var showSubtasks: Bool = false
	@State private var isHovering: Bool = false
	@Binding var currentlyDragging: PublicTasksModel?
	@Binding var currentlyDraggingSection: PublicProjectSectionModel?
	var task: PublicTasksModel
	var section: PublicProjectSectionModel
	
	//	let task: PublicTasksModel = .init(id: UUID(), name: "First Task", is_complete: false)
	
	let subtasks: [PublicTasksModel] = [
		.init(id: UUID(), name: "First Subtask", is_complete: false),
		.init(id: UUID(), name: "Second Subtask", is_complete: false),
		.init(id: UUID(), name: "Third Subtask", is_complete: false),
		.init(id: UUID(), name: "Fourth Subtask", is_complete: false),
		.init(id: UUID(), name: "Fifth Subtask", is_complete: false),
		.init(id: UUID(), name: "Sixth Subtask", is_complete: false),
		.init(id: UUID(), name: "Seventh Subtask", is_complete: false)
	]
	
	let columns = Array(repeating: GridItem(), count: 5)
	
	var body: some View {
		VStack(alignment: .leading) {
			Image("cardImage")
				.resizable()
				.scaledToFill()
				.frame(maxHeight: 200)
				.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
			
			HStack {
				LazyVGrid(columns: columns) {
					Capsule()
						.frame(height: 4)
						.foregroundStyle(.red)
					
					Capsule()
						.frame(height: 4)
						.foregroundStyle(.yellow)
					
					Capsule()
						.frame(height: 4)
						.foregroundStyle(.green)
					
					Capsule()
						.frame(height: 4)
						.foregroundStyle(.purple)
				}
			}
			
			HStack {
				Button {
					withAnimation {
//						task.is_complete.toggle()
					}
				} label: {
					if task.is_complete {
						Image(systemName: "checkmark.circle.fill")
							.foregroundStyle(.green)
							.listRowSeparator(.hidden)
					} else {
						Image(systemName: "checkmark.circle")
							.listRowSeparator(.hidden)
					}
				}
				
				Text(task.name)
			}
			.font(.subheadline)
			
			HStack {
				AvatarView(image: "IMG_0455.jpeg", fallback: "Nick Black", size: .tiny)
				
				if let endDate = task.end_date {
					Text(endDate, format: Date.FormatStyle().day().month())
						.font(.caption)
						.foregroundStyle(.green)
				}
				
				
				Spacer()
				
				Image(systemName: "hand.thumbsup")
					.font(.caption2)
					.foregroundStyle(.secondary)
				
				HStack(spacing: 0) {
					Text("1")
					Image(systemName: "message")
				}
				.font(.caption2)
				.foregroundStyle(.secondary)
				
				Button {
					withAnimation(.smooth) {
						showSubtasks.toggle()
					}
				} label: {
					HStack(spacing: 0) {
						Text("1")
						Image(systemName: "message")
						
						if showSubtasks {
							withAnimation {
								Image(systemName: "chevron.down")
							}
						} else {
							withAnimation {
								Image(systemName: "chevron.right")
							}
						}
						
					}
					.font(.caption2)
					.foregroundStyle(.secondary)
				}
				.buttonStyle(.plain)
				
			}
			
			if showSubtasks {
				if let subtasks = task.subtasks {
					ForEach(subtasks) { task in
						HStack {
							Image(systemName: "checkmark.circle")
								.foregroundStyle(.secondary)
							Text(task.name)
						}
						.font(.subheadline)
					}
					
					HStack {
						Image(systemName: "plus")
						Text("Add subtask")
					}
					.font(.caption)
					.foregroundStyle(.secondary)
				}
			}
		}
		.listStyle(.plain)
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.contentShape(.dragPreview, RoundedRectangle(cornerRadius: 10))
		.frame(maxWidth: 250)
		.onHover { hovering in
			isHovering = hovering
		}
		.background(.white)
		.draggable(task.id.uuidString) {
			TaskCardView(currentlyDragging: .constant(nil), currentlyDraggingSection: .constant(nil), task: task, section: section)
				.onAppear {
					currentlyDragging = task
					currentlyDraggingSection = section
				}
		}
	}
}

#Preview {
	ZStack {
		Color(uiColor: .systemGray6)
		TaskCardView(currentlyDragging: .constant(nil), currentlyDraggingSection: .constant(nil), task: .init(id: UUID(), name: "Task name", is_complete: false, end_date: Date(), subtasks: [
			.init(id: UUID(), name: "First Subtask", is_complete: false),
			.init(id: UUID(), name: "Second Subtask", is_complete: false),
			.init(id: UUID(), name: "Third Subtask", is_complete: false),
			.init(id: UUID(), name: "Fourth Subtask", is_complete: false),
			.init(id: UUID(), name: "Fifth Subtask", is_complete: false),
			.init(id: UUID(), name: "Sixth Subtask", is_complete: false),
			.init(id: UUID(), name: "Seventh Subtask", is_complete: false)
		]), section: .init(id: UUID(), name: "testing"))
	}
}
