import SwiftUI

struct ProjectListItem: View {
    @State private var isHovering: Bool = true
    var name: String
    var color: Color
    
    var body: some View {
        Label {
            Text(name)
                .lineLimit(1)
        } icon: {
            RoundedRectangle(cornerRadius: 5)
                .fill(color)
                .frame(width: 25, height: 25)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .listRowBackground(isHovering ? Color.navigationBackgroundHover : nil)
        .onHover {
            isHovering = $0
#if targetEnvironment(macCatalyst)
            DispatchQueue.main.async {
                if (self.isHovering) {
                    NSCursor.pointingHand.push()
                } else {
                    NSCursor.pop()
                }
            }
#endif
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
