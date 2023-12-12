import SwiftUI
import SwiftData

struct NewSectionForm: View {
    @Environment(\.modelContext) private var modelContext
//    @Query(filter: #Predicate<TaskModel> { !$0.isCompleted })
    @Query private var tasks: [TaskModel]
    @State private var name: String = ""
    @State private var selectedTasks: [TaskModel] = []
    @Binding var showProjectSheet: Bool
    
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
                modelContext.insert(SectionModel(name: name, tasks: selectedTasks))
            }
        }
    }
}

#Preview {
    NewSectionForm(showProjectSheet: .constant(true))
}
