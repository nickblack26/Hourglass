import SwiftUI

struct PageTabButton: View {
    @State private var isHovering: Bool = false
    var title: String
    var image: String
    var isSelected: Bool
    var showDropdown: Bool
    
    var body: some View {
        HStack {
            Label(title, systemImage: image)
                .lineLimit(1)
                .font(.subheadline)
                .foregroundStyle(isSelected ? .primary : .secondary)
                
            
            if(isSelected && showDropdown) {
                Menu {
                    Button {
                        
                    } label: {
                        Text("Set as default")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
                
            }
        }
        .onHover(perform: { isHovering = $0 })
        .padding(4)
        .background(.ultraThinMaterial.opacity(isHovering || isSelected ? 1 : 0), in: .rect(cornerRadius: 8))
    }
}

#Preview {
    PageTabButton(title: "Overview", image: "clipboard", isSelected: false, showDropdown: true)
}
