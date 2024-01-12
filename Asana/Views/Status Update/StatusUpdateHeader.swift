import SwiftUI

struct StatusUpdateHeader: View {
    var body: some View {
        HStack(spacing: 16) {
            Text("My first portfolio")
                .foregroundStyle(.secondary)
            Image(systemName: "chevron.right")
            Text("Status update")
            
            Spacer()
            
            Label("Public", systemImage: "person.2.fill")
            
            Divider()
                .frame(maxHeight: 24)
            
            Text("0 people will be notified")
                .foregroundStyle(.secondary)
                .font(.subheadline)
            
            Button("Post") {
                
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    StatusUpdateHeader()
}
