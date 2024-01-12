import SwiftUI

struct TableTagCellView: View {
    @Environment(AsanaManager.self) private var asanaManager
    @Binding var projects: [Project]
    
    var body: some View {
        HStack {
            ForEach($projects) { $project in
                TagView(tag: $project, allTags: $projects)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(.bar, in: .rect(cornerRadius: 8))        
    }
}

fileprivate struct TagView: View {
    @Binding var tag: Project
    @Binding var allTags: [Project]
    @FocusState private var isFocused: Bool
    
    var body: some View {
        TextField("Tag", text: $tag.name)
            .textFieldStyle(.roundedBorder)
            .focused($isFocused)
            .padding(.horizontal, isFocused || tag.name.isEmpty ? 0 : 10)
            .padding(.vertical, 10)
            .background(
                .white.opacity(isFocused || tag.name.isEmpty ? 0 : 1),
                in: .rect(cornerRadius: 5)
            )
            .overlay {
                Rectangle()
                    .fill(.clear)
                    .contentShape(.rect)
                    .onTapGesture {
                        isFocused = true
                    }
            }
    }
}

#Preview {
    let project = Project(name: "")

    return TableTagCellView(projects: .constant([project]))
        .modelContainer(previewContainer)

}
