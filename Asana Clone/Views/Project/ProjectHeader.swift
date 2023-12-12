import SwiftUI

struct ProjectHeader: View {
    @State private var showColorPicker: Bool = false
	@Binding var selectedTab: ProjectTab
	@Bindable var project: ProjectModel
	
    var body: some View {
		HStack {
			Button {
                showColorPicker.toggle()
			} label: {
                Image(project.icon.icon)
					.resizable()
					.frame(width: 25, height: 25)
					.padding()
					.background {
						RoundedRectangle(cornerRadius: 10)
                            .fill(project.color.color)
					}
			}
            .buttonStyle(.plain)
            .popover(isPresented: $showColorPicker, content: {
                List {
                    Picker("Colors", selection: $project.color) {
                        VStack {
                            HStack {
                                ForEach(0..<8, id: \.self) { index in
                                    Image(systemName: project.color == ProjectColor.allCases[index] ? "checkmark.square.fill" : "square.fill")
                                        .tint(ProjectColor.allCases[index].color)
                                        .tag(ProjectColor.allCases[index])
                                }
                            }
                            
                            HStack {
                                ForEach(8..<16, id: \.self) { index in
                                    Image(systemName: project.color == ProjectColor.allCases[index] ? "checkmark.square.fill" : "square.fill")
                                        .tint(ProjectColor.allCases[index].color)
                                        .tag(ProjectColor.allCases[index])
                                }
                            }
                        }
                    }
                    .pickerStyle(.palette)
                    .paletteSelectionEffect(.custom)
                }
            })
			
			VStack(alignment: .leading) {
				HStack {
                    TextField("Project name", text: $project.name)
						.font(.title2)
						.fontWeight(.medium)
					
					Menu {
						Button {
							
						} label: {
							Label("Edit project details", systemImage: "pencil")
						}
						
						Menu {
                            Picker("Colors", selection: $project.color) {
                                ForEach(ProjectColor.allCases, id: \.self) { color in
                                    Image(systemName: project.color == color ? "checkmark.square.fill" : "square.fill")
                                        .tint(color.color)
                                        .tag(color)
                                }
                            }
                            .pickerStyle(.palette)
                            .paletteSelectionEffect(.custom)
                            
                            Divider()
                            
                            Picker("Icons", selection: $project.color) {
                                ForEach(ProjectIcon.allCases, id: \.self) { icon in
                                    Image(icon.icon)
                                        .tint(project.color.color)
                                        .tag(icon)
                                }
                            }
                            .pickerStyle(.palette)
                            .paletteSelectionEffect(.custom)
                            
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
