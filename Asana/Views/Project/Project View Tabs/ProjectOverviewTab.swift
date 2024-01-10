//
//  ProjectOverviewTab.swift
//  Asana Clone
//
//  Created by Nick on 7/6/23.
//

import SwiftUI

struct ProjectOverviewTab: View {
	@State private var description: String = "This project is a personal project that will develop my SwiftUI skills."
	
	var body: some View {
		Grid(alignment: .top) {
			GridRow {
				VStack(alignment: .leading) {
                    SwiftUI.Section {
						TextField("What's this project about?", text: $description)
							.lineLimit(4, reservesSpace: true)
					} header: {
						Text("Project description")
							.font(.title2)
							.fontWeight(.medium)
					}
					
                    SwiftUI.Section {
						let columns = Array(repeating: GridItem(), count: 3)
					
						LazyVGrid(columns: columns, alignment: .leading, content: {
							HStack {
								Image(systemName: "plus")
									.padding()
									.background {
										Circle()
											.stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [5]))
									}
								
								Text("Add member")
							}
							.foregroundStyle(.secondary)
							
							HStack {
                                AvatarView(
                                    image: tempUrl,
                                    fallback: "Nick Black",
                                    size: .large
                                )
								
								VStack(alignment: .leading) {
									Text("Nick Black")
									Text("Project Owner")
										.font(.caption)
										.foregroundStyle(.secondary)
								}
							}
						})
					} header: {
						Text("Project roles")
							.font(.title2)
							.fontWeight(.medium)
					}
					
                    SwiftUI.Section {
						HStack {
							Image("key_resources")
							
							VStack(alignment: .leading) {
								Text("Align your team around a shared vision with a project brief and supporting resources.")
								HStack {
									Label("Create project brief", systemImage: "line.horizontal.star.fill.line.horizontal")
									
									Label("Add links & files", systemImage: "paperclip")
								}
							}
						}
						.padding()
						.background {
							RoundedRectangle(cornerRadius: 5)
								.fill(.clear)
								.stroke(.gray.opacity(0.25))
						}
					} header: {
						Text("Key resources")
							.font(.title2)
							.fontWeight(.medium)
					}
				}
				.padding()
				.gridCellColumns(2)
				
				VStack(alignment: .leading) {
					Text("What's the status?")
						.font(.title2)
						.fontWeight(.bold)
						.foregroundStyle(.secondary)
					
					Spacer()
				}
				.padding()
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(.gray.tertiary.opacity(0.25))
			}
		}
	}
}

#Preview {
	ProjectOverviewTab()
}
