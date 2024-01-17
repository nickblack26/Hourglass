import SwiftUI

struct LabeledInput<Content: View>: View {
    var title: String
    @ViewBuilder var content: () -> Content
    
    init(_ title: String, content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(.secondary)
                .fontWeight(.medium)
            
           content()
        }
    }
}

#Preview {
    LabeledInput("Field title") {
        Text("")
    }
}
