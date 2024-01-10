import SwiftUI

struct NavigationMenu: View {
    @Environment(AsanaManager.self) private var asanaManager
    
    var body: some View {
        HStack(spacing: 16) {
            Button {
                if asanaManager.columnVisibility == .doubleColumn {
                    asanaManager.columnVisibility = .detailOnly
                } else {
                    asanaManager.columnVisibility = .doubleColumn
                }
            } label: {
                Image(systemName: "line.3.horizontal")
            }
            
            Button("Create", systemImage: "plus.circle.fill") {
                
            }
            .buttonStyle(.bordered)
            .clipShape(Capsule())
            
            Spacer()
            
            Button {} label: {
                Image(systemName: "clock")
            }
            
            CustomSearchBar()
                .clipShape(Capsule())
                .frame(maxWidth: 500, maxHeight: 40)
            
            Spacer()
            
            Menu {
                
            } label: {
                HStack {
                    AvatarView(image: tempUrl, fallback: "Nick Black", size: .medium)
                    Image(systemName: "chevron.down")
                }
            }
        }
        .padding([.horizontal, .bottom])
    }
}

#Preview {
    NavigationMenu()
}

struct CustomSearchBar: UIViewRepresentable {
    func makeUIView(context: Context) -> UISearchTextField {
        let textField = UISearchTextField()
        textField.allowsDeletingTokens = true
        textField.allowsCopyingTokens = true
        textField.placeholder = "Search"
        textField.text = ""
        return textField
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
