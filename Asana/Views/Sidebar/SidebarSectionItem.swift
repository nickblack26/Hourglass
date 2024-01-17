import SwiftUI

struct SidebarSectionItem<Content: View, Action: View>: View {
    @State private var isExpanded: Bool = true
    @State private var isHovering: Bool = true
    var label: String
    @ViewBuilder var content: () -> Content
    @ViewBuilder var action: () -> Action
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            content()
        } label: {
            HStack {
                Text(label)
                    .font(.headline)
                    .fontWeight(.medium)
                
                Spacer()
                
                Menu {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.callout)
                }
                .opacity(isHovering ? 1 : 0)
                
                Menu {
                    action()
                } label: {
                    Image(systemName: "plus")
                        .font(.callout)
                }
                .opacity(isHovering ? 1 : 0)
            }
            .onHover(perform: { hovering in
                isHovering = hovering
            })
        }
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
            
            
            SidebarSectionItem(label: "Insights") {
                NavigationLink(value: SidebarLink.reporting) {
                    Label("Reporting", systemImage: "chart.xyaxis.line")
                }
                
                NavigationLink(value: SidebarLink.portfolios) {
                    Label("Portfolios", systemImage: "folder")
                }
                
                NavigationLink(value: SidebarLink.goals) {
                    Label("Goals", systemImage: "mountain.2")
                }
            } action: {
                
            }
        }
    } detail: {
        
    }
}
