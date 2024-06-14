import SwiftUI

struct ProjectHeader: View {
    @Environment(HourglassManager.self) private var hourglass
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
                    .frame(width: 24, height: 24)
                    .padding(8)
					.background(project.color.color, in: .rect(cornerRadius: 8))
            }
            
            VStack(alignment: .leading) {
                HStack {
                    TextField("Project name", text: $project.name, axis: .horizontal)
                        .font(.title2)
                        .fontWeight(.medium)
                        .fixedSize()
                    
                    ProjectActionsMenu(project)
                    
                    
                    
                    
                }
                
                HStack {
                    ForEach(Project.Tab.allCases, id: \.self) { tab in
                        Button {
                            withAnimation(.snappy) {
                                selectedTab = tab
                            }
                        } label: {
							PageTabButton(
								title: tab.rawValue,
								image: tab.image,
								isSelected: selectedTab == tab,
								showDropdown: tab.showMenu
							)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            
            Spacer()
            
            HStack {                
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
    @Previewable @State var hourglass = HourglassManager()
    let project = Project(name: "")
    
    return ProjectHeader(selectedTab: .constant(.board), project: project)
        .environment(hourglass)
        .modelContainer(previewContainer)
}
