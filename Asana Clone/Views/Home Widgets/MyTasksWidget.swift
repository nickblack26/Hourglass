//
//  MyTasksWidget.swift
//  Asana Clone
//
//  Created by Nick on 6/27/23.
//

import SwiftUI

enum MyTasksTab: String, CaseIterable {
	case upcoming = "Upcoming"
	case overdue = "Overdue"
	case completed = "Completed"
}

struct MyTasksWidget: View {
	@State private var vm = MyTasksWidgetViewModel()
	@State private var tabSelection: MyTasksTab = .upcoming
	@State private var selectedTask: PublicTasksModel? = nil
	@State private var openSheet: Bool = false
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Image("profile")
					.resizable()
					.scaledToFill()
					.frame(width: 50, height: 50)
					.cornerRadius(50)
				
				VStack(alignment: .leading) {
					HStack {
						Text("My Tasks")
							.font(.title3)
							.fontWeight(.bold)
						
						Image(systemName: "lock.fill")
							.foregroundStyle(.secondary)
							.font(.footnote)
					}
					
					HStack {
						ForEach(MyTasksTab.allCases, id: \.self) { tab in
							Button {
								tabSelection = tab
							} label: {
								Text(tab.rawValue)
									.foregroundStyle(tabSelection == tab ? .primary : .secondary )
									.padding(.trailing, 5)
							}
							.buttonStyle(.plain)
						}
					}
				}
			}
			.padding(.horizontal)
			.padding(.top)
			
			TabView(selection: $tabSelection) {
				ForEach(vm.upcoming) { task in
					HStack {
						Button {
							
						} label: {
							Image(systemName: task.is_complete ? "checkmark.circle.fill" : "checkmark.circle")
								.foregroundStyle(task.is_complete ? .green : .primary)
						}
						.buttonStyle(.plain)
						
						Button {
							selectedTask = task
							openSheet.toggle()
						} label: {
							Text(task.name)
						}
						.buttonStyle(.plain)
					}
				}
				.tag(MyTasksTab.upcoming)
				
				ForEach(vm.overdue) { task in
					HStack {
						Button {
							
						} label: {
							Image(systemName: task.is_complete ? "checkmark.circle.fill" : "checkmark.circle")
								.foregroundStyle(task.is_complete ? .green : .primary)
						}
						.buttonStyle(.plain)
						
						Button {
							selectedTask = task
							openSheet.toggle()
						} label: {
							Text(task.name)
						}
						.buttonStyle(.plain)
					}
				}
				.tag(MyTasksTab.overdue)
				
				ForEach(vm.overdue) { task in
					HStack {
						Button {
							
						} label: {
							Image(systemName: task.is_complete ? "checkmark.circle.fill" : "checkmark.circle")
								.foregroundStyle(task.is_complete ? .green : .primary)
						}
						.buttonStyle(.plain)
						
						Button {
							selectedTask = task
							openSheet.toggle()
						} label: {
							Text(task.name)
						}
						.buttonStyle(.plain)
					}
				}
				.tag(MyTasksTab.completed)
			}
		}
		.padding()
		.frame(height: 400)
		.background {
			RoundedRectangle(cornerRadius: 10)
				.fill(.cardBackground)
				.stroke(.cardBorder, lineWidth: 1)
		}
	}
}

#Preview {
	MyTasksWidget()
}
