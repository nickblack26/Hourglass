import SwiftUI

struct ProjectListItem: View {
    @State private var isHovering: Bool = true
    var title: String
    var subtitle: String?
    var color: Color
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(color)
                .frame(width: 24, height: 24)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.regular)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.caption)
                }
            }
            .lineLimit(1)
            .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    NavigationSplitView {
        List {
            ProjectListItem(
                title: "Create Marketing Campaign",
                subtitle: "Acme Corp.",
                color: .aqua
            )
        }
    } detail: {
        EmptyView()
    }
}
