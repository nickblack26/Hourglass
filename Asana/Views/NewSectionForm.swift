import SwiftUI
import SwiftData

struct NewSectionForm: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query(
        filter: #Predicate<Task> { !$0.isCompleted },
        sort: \Task.order
    )
    private var tasks: [Task]
    @State private var name: String = ""
    @State private var selectedTasks: [Task] = []
    @Binding var showProjectSheet: Bool
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
                        showProjectSheet.toggle()
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
        let section = Section(name: name, order: 0)
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
    NewSectionForm(showProjectSheet: .constant(true), project: .preview)
}
