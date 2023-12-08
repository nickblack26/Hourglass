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
	@Binding var currentlyDragging: TaskModel?
	@Binding var currentlyDraggingSection: SectionModel?
	var task: TaskModel
	var section: SectionModel
		
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
					if task.isCompleted {
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
				
				if let endDate = task.endDate {
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
//        .draggable(task.id) {
//			TaskCardView(currentlyDragging: .constant(nil), currentlyDraggingSection: .constant(nil), task: task, section: section)
//				.onAppear {
//					currentlyDragging = task
//					currentlyDraggingSection = section
//				}
//		}
	}
}

#Preview {
	ZStack {
		Color(uiColor: .systemGray6)
        TaskCardView(currentlyDragging: .constant(nil), currentlyDraggingSection: .constant(nil), task: .preview[0], section: .preview)
	}
}
