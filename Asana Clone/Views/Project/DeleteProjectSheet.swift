import SwiftUI

struct DeleteProjectSheet: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var project: Project
    
    init(_ project: Project) {
        self.project = project
    }
    
    var body: some View {
        SwiftUI.Section {
            VStack(alignment: .leading) {
                Text("This will delete the project, along with any:")
                Text(" • Unassigned tasks that are only in this project")
                Text(" • Custom fields that are local to this project")
                Text(" • Rules in this project")
                Text(" • Task templates in this project")
                Text(" • Read-only links for this project")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        } header: {
            HStack {
                Text("Delete the '\(project.name)' project?")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            .padding([.top, .horizontal])
            
            Divider()
        } footer: {
            Divider()
            
            HStack {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.clear)
                .foregroundStyle(.primary)
                
                Button("Delete", role: .destructive) {
                    withAnimation(.snappy) {
                        context.delete(project)
                        dismiss()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            .padding([.bottom, .horizontal])
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    DeleteProjectSheet(.preview)
}
