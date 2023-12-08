//
//  ProjectHeader.swift
//  Asana Clone
//
//  Created by Nick on 7/21/23.
//

import SwiftUI

struct ProjectHeader: View {
	@Binding var selectedTab: ProjectTab
	var project: ProjectModel
	
    var body: some View {
		HStack {
			Menu {
				LazyVGrid(columns: Array(repeating: GridItem(), count: 8)) {
					ForEach(ProjectColor.allCases, id: \.self) {color in
						Button {
							
						} label: {
							RoundedRectangle(cornerRadius: 2.5)
								.fill(color.color)
								.overlay {
									Image(systemName: "checkmark")
								}
						}
						.buttonStyle(.plain)
					}
				}
			} label: {
				Image("project_calendar_icon")
					.resizable()
					.frame(width: 25, height: 25)
					.padding()
					.background {
						RoundedRectangle(cornerRadius: 10)
							.fill(.gray)
					}
			}
			
			VStack(alignment: .leading) {
				HStack {
					Text(project.name)
						.font(.title2)
						.fontWeight(.medium)
					
					Menu {
						Button {
							
						} label: {
							Label("Edit project details", systemImage: "pencil")
						}
						
						Menu {
							Button {
								
							} label: {
								Text("eh")
							}
							
						} label: {
							Label {
								Text("Set color & icon")
							} icon: {
								Image(systemName: "square.fill")
									.foregroundStyle(.yellow)
							}
						}
						
						
					} label: {
						Image(systemName: "chevron.down")
					}
					Image(systemName: "star")
						.fontWeight(.light)
					
					Menu {
						Section {
							Button {
								
							} label: {
								Label("On track", systemImage: "circle.fill")
							}
							
							Button {
								
							} label: {
								Label("At risk", systemImage: "circle.fill")
							}
							Button {
								
							} label: {
								Label("Off track", systemImage: "circle.fill")
							}
							Button {
								
							} label: {
								Label("On hold", systemImage: "circle.fill")
							}
						}
						
						Section {
							Button {
								
							} label: {
								Label("Complete", systemImage: "checkmark")
							}
						}
						
					} label: {
						Label("Set status", systemImage: "circle")
					}
				}
				
				HStack {
					ForEach(ProjectTab.allCases, id: \.self) { tab in
						Button {
							withAnimation {
								selectedTab = tab
							}
						} label: {
							Text(tab.rawValue)
								.foregroundStyle(selectedTab == tab ? .primary : .secondary)
							
							if(selectedTab == tab && selectedTab.showMenu) {
								Menu {
									Button {
										
									} label: {
										Text("Set as default")
									}
								} label: {
									Image(systemName: "ellipsis")
								}
								
							}
						}
						.buttonStyle(.plain)
					}
				}
			}
			
			Spacer()
			
			HStack {
				AvatarView(image: "IMG_0455.jpeg", fallback: "Nicholas Black", size: .small)
				
				Button {
					
				} label: {
					Label("Share", systemImage: "lock")
				}
				
				Divider().frame(height: 25)
				
				Button {
					
				} label: {
					Label("Customize", systemImage: "square.grid.2x2")
				}
			}
		}
		.padding()
    }
}

#Preview {
    ProjectHeader(selectedTab: .constant(.board), project: .preview)
}
