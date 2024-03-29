import SwiftUI

struct NavigationMenu: View {
    @Environment(HourglassManager.self) private var hourglass
    
    var body: some View {
        HStack(spacing: 16) {
            Button {
                if hourglass.columnVisibility == .doubleColumn {
                    hourglass.columnVisibility = .detailOnly
                } else {
                    hourglass.columnVisibility = .doubleColumn
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
                    AvatarView(fallback: "Nick Black", size: .medium)
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
