import SwiftUI
import SwiftData

struct ColumnView: View {
    @Environment(HourglassManager.self) private var hourglass
    @Query var tasks: [aTask]
    @Bindable var section: aSection
	var filter: aTask.Filter?
    
    init(section: aSection, filter: aTask.Filter? = nil) {
        self.section = section
        let sectionId = section.persistentModelID
        self._tasks = .init(
            filter: #Predicate<aTask> {
                $0.section != nil && $0.section?.persistentModelID == sectionId
            },
            sort: \.order,
            animation: .snappy
        )
    }
    
    var body: some View {
        ScrollView(.vertical) {
            Section {
                TasksView($section.tasks)
            } header: {
                HStack {
                    TextField(
                        "Section Name",
                        text: $section.name,
                        prompt: Text("Untitled section")
                    )
                    .font(.title3)
                    .fontWeight(.medium)
                    
                    Button {
                        withAnimation(.snappy) {
                            section.addTaskToSection()
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.plain)
                    
                    Menu {
                        SectionActionsContent(
                            viewType: .board,
                            sections: .constant([]),
                            section: section
                        )
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .frame(width: 375, alignment: .leading)
        #if os(iOS)
        .background(section.tasks != nil && section.tasks!.isEmpty ? Color(uiColor: .systemGray6).opacity(0.5) : .clear)
        #endif
        #if os(macOS)
        .background(section.tasks != nil && section.tasks!.isEmpty ? Color(nsColor: .systemGray).opacity(0.5) : .clear)
        #endif
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .dropDestination(for: aTask.self) { items, location in
            withAnimation(.snappy) {
                if let draggingTask = hourglass.draggingTask {
                    draggingTask.updateSection(section: section)
                }
            }
            return true
        } isTargeted: { status in }
    }
}

#Preview {
    ColumnView(section: .init(name: "", order: 0))
}
