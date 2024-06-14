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
        .frame(maxWidth: .infinity, alignment: .leading)
        #if os(iOS)
        .background(
            Color(uiColor: .systemGray6).opacity(0.625),
            in: .rect(cornerRadius: 12)
        )
        #endif
        #if os(macOS)
        .background(
            Color(nsColor: .systemGray).opacity(0.625),
            in: .rect(cornerRadius: 12)
        )
        #endif
//            .background {
//                RoundedRectangle(cornerRadius: 12)
//                    .fill(.background)
//                    .stroke(
//                        isHovering ? Color(uiColor: .systemGray3) : Color(uiColor: .systemGray5),
//                        lineWidth: 1
//                    )
//                    .shadow(
//                        color: isHovering ? .secondary.opacity(0.1) : .clear,
//                        radius: 16,
//                        x: 0.0,
//                        y: 0.0
//                    )
//            }
            .onHover(perform: { isHovering = $0 })
    }
}

#Preview {
    Card {
        Text("Hello")
    }
}
