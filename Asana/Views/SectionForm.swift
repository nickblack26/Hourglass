import SwiftUI
import SwiftData

struct SectionForm: View {
    // MARK: Environment Variables
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    // MARK: Swift Data
    @Query(
        filter: #Predicate<aTask> { !$0.isCompleted },
        sort: \aTask.order
    )
    private var tasks: [aTask]
    
    // MARK: State variables
    @State private var name: String = ""
    @State private var selectedTasks: [aTask] = []
    @Bindable var project: Project
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Section name", text: $name)
                
                Picker("Tasks", selection: $selectedTasks) {
                    ForEach(tasks) { task in
                        Text(task.name)
                            .tag(task)
                    }
                }
                .pickerStyle(.navigationLink)
                
                Button("Submit") {
                    newSection()
                }
                .buttonStyle(.borderedProminent)
                .tint(.accent)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .navigationTitle("New section")
            .onSubmit {
                newSection()
            }
        }
    }
    
    private func newSection() {
        let section = aSection(name: name, order: 0)
        modelContext.insert(section)
        
        if let sections = project.sections, !sections.isEmpty {
            for index in sections.indices {
                @Bindable var section = sections[index]
                section.order = index + 1
            }
            project.sections!.insert(section, at: 0)
        } else {
            project.sections?.append(section)
        }
        
        dismiss()
    }
    
}

#Preview {
    let project = Project(name: "")

    return SectionForm(project: project)
        .modelContainer(previewContainer)

}
