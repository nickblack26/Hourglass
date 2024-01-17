import SwiftUI

struct ClientSheetContent: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Bindable var client: Client
    
    init() {
        let newClient = Client(name: "")
        self.client = newClient
    }
    
    init(client: Client) {
        self.client = client
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $client.name)
            }
            .onSubmit {
                withAnimation(.snappy) {
                    context.insert(client)
                    dismiss()
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .primaryAction) {
                    Button("Close", systemImage: "xmark") {
                        dismiss()
                    }
                }
            })
        }
    }
}

#Preview {
    ClientSheetContent()
}
