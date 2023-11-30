//
//  ProjectWidget.swift
//  Asana Clone
//
//  Created by Nick on 6/30/23.
//

import SwiftUI

struct ProjectWidget: View {
	@State private var vm = ProjectsWidgetViewModel()
	
	// eventually be able to pass the amount of columns to show
	// this will depend on whether or not the card is full width or not
	let colNum = 2
	
	var body: some View {
		VStack(alignment: .leading) {
			Text("Projects")
				.font(.title2)
				.fontWeight(.bold)
			
			let columns = Array(repeating: GridItem(spacing: 15), count: colNum)
			
			LazyVGrid(columns: columns, alignment: .leading, spacing: 15) {
				NavigationLink(destination: NewProjectView(isPresented: .constant(true))) {
					HStack {
						Image(systemName: "plus")
							.foregroundStyle(.secondary)
							.padding()
							.background {
								RoundedRectangle(cornerRadius: 5)
									.strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [1]))
							}
						
						Text("Create project")
					}
				}
				ForEach(vm.projects) { project in
					HStack {
						Image(systemName: "list.bullet")
							.symbolRenderingMode(.hierarchical)
							.padding()
							.background {
								RoundedRectangle(cornerRadius: 5)
									.fill(.mint)
							}
						VStack(alignment: .leading) {
							Text(project.name)
								.lineLimit(1)
								.fontWeight(.semibold)
							
							Text("3 tasks due soon")
								.foregroundStyle(.secondary)
								.lineLimit(1)
						}
					}
				}
			}
			
//			LazyVGrid(alignment: .center) {
//				GridRow(alignment: .top) {
//					NavigationLink(destination: NewProjectView()) {
//						HStack {
//							Image(systemName: "plus")
//								.foregroundStyle(.secondary)
//								.padding()
//								.background {
//									RoundedRectangle(cornerRadius: 5)
//										.strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [1]))
//								}
//							
//							Text("Create project")
//						}
//					}
//					
//					List(vm.projects) { project in
//						HStack {
//							Image(systemName: "list.bullet")
//								.symbolRenderingMode(.hierarchical)
//								.padding()
//								.background {
//									RoundedRectangle(cornerRadius: 5)
//										.fill(.mint)
//								}
//							VStack(alignment: .leading) {
//								Text(project.name)
//									.lineLimit(1)
//									.fontWeight(.semibold)
//								
//								Text("3 tasks due soon")
//									.foregroundStyle(.secondary)
//									.lineLimit(1)
//							}
//						}
//						.listRowSeparator(.hidden)
//						.listRowBackground(EmptyView())
//					}
//					.listStyle(.plain)
//				}
//			}
			
			Spacer()
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
	ProjectWidget()
}
