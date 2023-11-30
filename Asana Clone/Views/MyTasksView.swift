//
//  MyTasksView.swift
//  Asana Clone
//
//  Created by Nick on 6/22/23.
//

import SwiftUI

enum TaskView: String, CaseIterable, Identifiable {
	var id: Self {
		return self
	}
	
	case list = "List"
	case board = "Board"
	case calendar = "Calendar"
}

struct MyTasksView: View {
	@State private var vm = MyTasksViewModel()
	@State private var view: TaskView = .list
	@State private var selectedTasks = Set<PublicTasksModel.ID>()
	@State private var sortOrder = [KeyPathComparator(\PublicTasksModel.name)]
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Image("profile")
					.resizable()
					.scaledToFill()
					.frame(width: 50, height: 50)
					.cornerRadius(50)
				
				VStack(alignment: .leading) {
					Text("My Tasks")
						.font(.title3)
						.fontWeight(.bold)
					
					Picker("", selection: $view) {
						ForEach(TaskView.allCases) { view in
							Text(view.rawValue)
								.tag(view)
						}
					}
					.pickerStyle(.segmented)
				}
			}
			.padding(.horizontal)
			.padding(.top)
			
			Divider()
			
//			Table(state.animals, selection: $state.selection) {
//				TableColumn("Name") { animal in
//					HStack {
//						Text(animal.emoji).font(.title)
//							.padding(2)
//							.background(.thickMaterial, in: RoundedRectangle(cornerRadius: 3))
//						Text(animal.name + " " + animal.species).font(.title3)
//					}
//				}
//				TableColumn("Favorite Fruits") { animal in
//					HStack {
//						ForEach(animal.favoriteFruits.prefix(3)) { fruit in
//							FruitImage(fruit: fruit, size: .init(width: fruitWidth, height: fruitWidth), scale: 2.0, bordered: state.selection == animal.id)
//						}
//					}
//					.padding(3.5)
//				}
//				TableColumn("Suspicion Level") { animal in
//					SuspicionTableCell(animal: animal)
//				}
//			}
//#if os(macOS)
//			.alternatingRowBackgrounds(.disabled)
//#endif
//			.tableStyle(.inset)
			
			Table(vm.recentTasks, selection: $selectedTasks) {
				TableColumn("") {
					Text($0.is_complete ? "Yes" : "No")
				}.width(25)
				
				TableColumn("Task name", value: \.name)
				
				TableColumn("Due date") { task in
					if(task.end_date != nil) {
						Text(task.end_date!.formatted(date: .numeric, time: .omitted))
					} 
				}
				
			}
		}
		.toolbar {
			EditButton()
		}
	}
}

#Preview {
	NavigationStack {
		MyTasksView()
	}
}
