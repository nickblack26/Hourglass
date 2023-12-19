import SwiftUI

struct ProjectHeader: View {
    @Environment(AsanaManager.self) private var asanaManager
    @State private var showColorPicker: Bool = false
    @Binding var selectedTab: Project.Tab
	@Bindable var project: Project
	
    var body: some View {
		HStack {
            Menu {
                ProjectThemeMenuContent(project)
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
			
			VStack(alignment: .leading) {
				HStack {
                    TextField("Project name", text: $project.name, axis: .horizontal)
						.font(.title2)
						.fontWeight(.medium)
                        .fixedSize()
					
					ProjectActionsMenu(project)
                    
                    Button {
                        withAnimation(.snappy) {
                            project.starred.toggle()
                        }
                    } label: {
                        Image(systemName: project.starred ? "star.fill" : "star")
                            .fontWeight(.light)
                            .foregroundStyle(project.color.color)
                    }
                    .buttonStyle(.bordered)
                    .tint(.clear)
                    .foregroundStyle(.primary)
					
                    ProjectStatusMenu(project)
				}
				
				HStack {
                    ForEach(Project.Tab.allCases, id: \.self) { tab in
						Button {
                            withAnimation(.snappy) {
								selectedTab = tab
							}
						} label: {
							Text(tab.rawValue)
								.foregroundStyle(selectedTab == tab ? .primary : .secondary)
							
							if(selectedTab == tab && selectedTab.showMenu) {
								Menu {
									Button {
                                        project.defaultTab = tab
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
                MemberGroupView(project.members)
				
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
    @State var asanaManager = AsanaManager.self()
    return ProjectHeader(selectedTab: .constant(.board), project: .preview)
        .environment(asanaManager)
}
