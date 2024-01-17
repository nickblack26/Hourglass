import SwiftUI

struct Card<Content: View>: View {
    @Binding var isHovering: Bool
    @ViewBuilder var content: () -> Content
    
    init(_ isHovering: Binding<Bool>, content: @escaping () -> Content) {
        self._isHovering = isHovering
        self.content = content
    }
    
    init(content: @escaping () -> Content) {
        self._isHovering = .constant(false)
        self.content = content
    }
    
    var body: some View {
        content()
            .padding(16)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.background)
                    .stroke(
                        isHovering ? Color(uiColor: .systemGray3) : Color(uiColor: .systemGray5),
                        lineWidth: 1
                    )
                    .shadow(
                        color: isHovering ? .secondary.opacity(0.1) : .clear,
                        radius: 16,
                        x: 0.0,
                        y: 0.0
                    )
            }
            .onHover(perform: { isHovering = $0 })
    }
}

#Preview {
    Card(.constant(true)) {
        Text("Hello")
    }
}
