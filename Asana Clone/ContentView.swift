import SwiftUI
import SwiftData

struct ContentView: View {
	@State var selectedLink: SidebarLink? = .home
	@State private var colorScheme: ColorScheme = .white
	@State private var showInspector: Bool = false
	@State private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
	
	var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility, sidebar: {
            SidebarView(selectedLink: $selectedLink)
        }, detail: {
            ContentDetail(selectedLink: $selectedLink)
                .inspector(isPresented: $showInspector) {
                    HomeInspector(colorScheme: $colorScheme)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu {
                            Section {
                                Button {
                                    
                                } label: {
                                    Label("Task", systemImage: "checkmark.circle")
                                }
                                
                                Button {
                                    
                                } label: {
                                    Label("Project", systemImage: "list.bullet.clipboard")
                                }
                                
                                Button {
                                    
                                } label: {
                                    Label("Message", systemImage: "message")
                                }
                            }
                            
                            Section {
                                Button {
                                    
                                } label: {
                                    Label("Invite", systemImage: "person.badge.plus")
                                }
                            }
                            
                        } label: {
                            Label("Create", systemImage: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            
                        } label: {
                            Text("Upgrade")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.yellow)
                        .foregroundStyle(.black)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Button {
                              
                            } label: {
                                Label("Sign out", systemImage: "arrow.right.to.line")
                            }
                        } label: {
                            Label("Menu", systemImage: "ellipsis")
                        }
                    }
                }
                .background(Color("defaultBackground"))
        })
        .tint(.primary)
	}
}


#Preview {
    ContentView()
}
	
