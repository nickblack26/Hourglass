import SwiftUI
import SwiftData

struct MemberPicker: View {
    @Environment(\.dismiss) var dismiss
    @Query private var members: [Member]
    @Binding var assignee: Member?
    
    init(_ assignee: Binding<Member?>) {
        self._assignee = assignee
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(members) { member in
                Button {
                    withAnimation(.snappy) {
                        assignee = member
                        dismiss()
                    }
                } label: {
                    HStack {
                        Text(member.name.isEmpty ? "This is a name" : member.name)
                        Text(member.email)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(8)
            }
            
            Divider()
            
            Button("Invite teammates via email", systemImage: "plus") {
                
            }
            .padding(8)
            
            Divider()
            
            Button("Assign to multiple people", systemImage: "person.2") {
                
            }
            .padding(8)
        }
    }
}

#Preview {
    @State var showPopover: Bool = false
    return ZStack {
        Button("Show popover") {
            showPopover.toggle()
        }
    }
    .modelContainer(for: Member.self, inMemory: true)
    .popover(isPresented: $showPopover, content: {
        MemberPicker(.constant(nil))
    })
    
}
