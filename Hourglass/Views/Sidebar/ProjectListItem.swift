import SwiftUI

struct ProjectListItem: View {
    @State private var isHovering: Bool = true
    var name: String
    var subtitle: String?
    var color: Color
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(color)
                .frame(width: 25, height: 25)
            
            VStack(alignment: .leading) {
                Text(name)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .lineLimit(1)
            .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    let project = Project(name: "")

    return NavigationSplitView {
        List {
            ProjectListItem(
                name: project.name,
                color: project.color.color
            )
        }
        .listStyle(.insetGrouped)
    } detail: {
        EmptyView()
    }
    .modelContainer(previewContainer)

}
