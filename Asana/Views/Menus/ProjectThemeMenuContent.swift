import SwiftUI

struct ProjectThemeMenuContent: View {
    @Bindable var project: Project
    
    init(_ project: Project) {
        self.project = project
    }
    
    var body: some View {
        SwiftUI.Section {
            Picker("Colors", selection: $project.color) {
                ForEach(AsanaColor.allCases, id: \.self) { color in
                    Image(systemName: project.color == color ? "checkmark.square.fill" : "square.fill")
                        .tint(color.color)
                        .tag(color)
                }
            }
            .pickerStyle(.palette)
            .paletteSelectionEffect(.custom)
        }
        
        SwiftUI.Section {
            Picker("Icons", selection: $project.icon) {
                ForEach(Project.Icon.allCases, id: \.self) { icon in
                    Image(icon.icon)
                        .background(project.icon == icon ? project.color.color : .clear)
                        .tint(project.icon == icon ? project.color.color : .primary)
                        .tag(icon)
                }
            }
            .pickerStyle(.palette)
            .paletteSelectionEffect(.custom)
        }
    }
}

#Preview {
    ProjectThemeMenuContent(.preview)
}
