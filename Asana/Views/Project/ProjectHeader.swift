import SwiftUI
import SwiftDataKit

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
                            SwiftUI.Task {
//                                await toggleFavorite()
                            }
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
                            PageTabButton(title: tab.rawValue, image: tab.image, isSelected: selectedTab == tab, showDropdown: tab.showMenu)
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
    @State var asanaManager = AsanaManager()
    let project = Project(name: "")
    
    return ProjectHeader(selectedTab: .constant(.board), project: project)
        .environment(asanaManager)
        .modelContainer(previewContainer)
}
