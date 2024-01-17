import SwiftUI
import SwiftData

struct TaskBoardView: View {
    @Environment(\.modelContext) private var context
    @State private var currentlyDraggingTask: aTask?
    @State private var currentlyDraggingSection: aSection?
    var project: Project?
    var sections: [aSection]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(sections) { section in
                    ColumnView(section: section)
                }
                VStack(alignment: .leading) {
                    Button("Add section", systemImage: "plus") {
                        withAnimation(.snappy) {
                            let section = aSection(name: "", order: sections.count)
                            if project != nil {
                                project?.sections?.append(section)
                            } else {
                                context.insert(section)
                            }
                        }
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    .padding()
                }
                .frame(width: 375, alignment: .topLeading)
                .frame(maxHeight: .infinity)
                .background(Color(uiColor: .systemGray6).opacity(0.5).gradient)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(.horizontal)
    }
}

//#Preview {
//    @State var asanaManager = AsanaManager()
//    let section = aSection(name: "", order: 0)
//
//    
//    return TaskBoardView([section])
//        .environment(asanaManager)
//        .modelContainer(previewContainer)
//
//}




