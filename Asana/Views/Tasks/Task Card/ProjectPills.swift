import SwiftUI

struct ProjectPills: View {
    let columns = Array(repeating: GridItem(), count: 5)
    var projects: [Project]
    
    init(_ projects: [Project]) {
        self.projects = projects
    }
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(projects) { project in
                Capsule()
                    .frame(height: 4)
                    .foregroundStyle(project.color.color)
            }
        }
    }
}

#Preview {
    let project = Project(name: "")

    return ProjectPills([project])
        .modelContainer(previewContainer)

}
