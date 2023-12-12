import SwiftUI

struct PrivateNotepadWidgetView: View {
    @Environment(AsanaManager.self) private var asanaManager
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        
        VStack(alignment: .leading) {
            Text("Private notepad \(Image(systemName: "lock.fill"))")
                .font(.title2)
                .fontWeight(.bold)
            
            TextField(
                "Notepad",
                text: Binding(
                    get: {
                        return asanaManager.currentMember?.notepad ?? ""
                    },
                    set: { newValue in
                        asanaManager.currentMember?.notepad = newValue
                    }),
                prompt: Text("Jot down a quick note or add a link to an important resource."),
                axis: .vertical
            )
            .lineLimit(20, reservesSpace: true)
            
        }
        .padding()
        .frame(height: 400)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.cardBackground)
                .stroke(.cardBorder, lineWidth: 1)
        }
    }
}

#Preview {
    @State var asanaManager = AsanaManager()
    return PrivateNotepadWidgetView()
        .environment(asanaManager)
}
