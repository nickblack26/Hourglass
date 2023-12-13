import SwiftUI

struct PrivateNotepadWidgetView: View {
    @Environment(AsanaManager.self) private var asanaManager
    @FocusState private var isFocused: Bool
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        
        VStack(alignment: .leading) {
            HStack {
                Text("Private notepad")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Image(systemName: "lock.fill")
                    .imageScale(.small)
                    .foregroundStyle(.secondary)
            }
            
//            TextEditor(
//                text: Binding(
//                    get: {
//                        return asanaManager.currentMember?.notepad ?? ""
//                    },
//                    set: { newValue in
//                        asanaManager.currentMember?.notepad = newValue
//                    }
//                )
//            )
//            .textFieldStyle(.roundedBorder)
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//            
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
            .focused($isFocused)
            .lineLimit(15, reservesSpace: true)
            
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
