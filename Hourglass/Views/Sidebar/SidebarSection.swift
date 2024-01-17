import SwiftUI

struct SidebarSection<Content: View>: View {
    @State private var isExpanded: Bool = true
    var label: String
    @ViewBuilder var content: () -> Content
	
	init(label: String, content: @escaping () -> Content) {
		self.label = label
		self.content = content
	}
	
	init(_ label: String, content: @escaping () -> Content) {
		self.label = label
		self.content = content
	}
    
    var body: some View {
        Section(label, isExpanded: $isExpanded) {
            content()
        }
		.headerProminence(.increased)
    }
}

#Preview {
    NavigationSplitView {
        List {
            NavigationLink(value: SidebarLink.home) {
                Label("Home", systemImage: "house")
            }
            
            NavigationLink(value: SidebarLink.myTasks) {
                Label("My Tasks", systemImage: "checkmark.circle")
            }
            
            NavigationLink(value: SidebarLink.inbox) {
                Label("Inbox", systemImage: "bell")
            }
            
            
            
        }
    } detail: {
        
    }
}
