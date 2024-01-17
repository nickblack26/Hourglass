import SwiftUI
import SwiftData

struct ColumnView: View {
    @Environment(HourglassManager.self) var hourglass
    @Query var tasks: [aTask]
    @Bindable var section: aSection
    
    init(section: aSection) {
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
                TasksView(tasks)
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
                            addTaskToSection()
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
        .background(section.tasks != nil && section.tasks!.isEmpty ? Color(uiColor: .systemGray6).opacity(0.5) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private func addTaskToSection() {
        if let project = section.project {
            let newTask = aTask(name: "", order: tasks.count, projects: [project], section: section)
            
            section.tasks?.append(newTask)
        } else  {
            let newTask = aTask(name: "", order: tasks.count, section: section)
            section.tasks?.append(newTask)
        }
    }
}

#Preview {
    ColumnView(section: .init(name: "", order: 0))
}
