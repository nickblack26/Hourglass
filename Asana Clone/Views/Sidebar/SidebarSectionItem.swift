import SwiftUI

struct SidebarSectionItem<Content: View>: View {
    @State private var isExpanded: Bool = true
    var label: String
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        SwiftUI.Section(isExpanded: $isExpanded) {
            content()
        } header: {
            HStack {
                Text(label)
                
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationSplitView {
        SidebarSectionItem(label: "Testing") {
            
        }
    } detail: {
        
    }
}
