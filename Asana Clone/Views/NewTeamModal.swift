import SwiftUI

struct NewTeamModal: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var members: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Create new workspace")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            
            Divider()
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Workspace Name")
                    
                    Text("Members")
                        .padding(.top)
                }
                
                VStack(alignment: .leading) {
                    TextField(
                        "Workspace Name",
                        text: $name,
                        prompt: Text("Company or Team Name")
                    )
                    .textFieldStyle(.roundedBorder)
                 
                    TextField(
                        "Workspace Name",
                        text: $members,
                        prompt: Text(verbatim: "name@company.com, ..."),
                        axis: .vertical
                    )
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3, reservesSpace: true)
                }
            }
            
            Divider()
            
            HStack {
                Spacer()
                
                Button("Create workspace") {
                    createNewTeam()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
    
    private func createNewTeam() {
        let team = Team(name: name)
        modelContext.insert(team)
        dismiss()
    }
    
}

#Preview {
    NavigationStack {
        NewTeamModal()
    }
}
