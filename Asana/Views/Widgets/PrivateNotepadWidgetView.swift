import SwiftUI

struct PrivateNotepadWidgetView: View {
	@State var attributedText = NSAttributedString(string: "Testing")
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
			TextView(
				attributedText: Binding(
					get: {

						return NSAttributedString(string: "")
					},
					set: { newValue in
						let data = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: true)
					}
				),
				allowsEditingTextAttributes: true
			)
        }
        .padding()
        .frame(height: 400)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.cardBackground)
                .stroke(.cardBorder, lineWidth: 1)
        }
    }
}

#Preview {
    @State var asanaManager = AsanaManager()
    return PrivateNotepadWidgetView().environment(asanaManager)
}


struct TextView: UIViewRepresentable {
	@Binding var attributedText: NSAttributedString
	@State var allowsEditingTextAttributes: Bool = false
	
	@State var font: UIFont? = UIFont.preferredFont(forTextStyle: .body)
	
	func makeUIView(context: Context) -> UITextView {
		UITextView()
	}
	
	func updateUIView(_ uiView: UITextView, context: Context) {
		uiView.attributedText = attributedText
		uiView.allowsEditingTextAttributes = allowsEditingTextAttributes
		uiView.font = font
	}
}
