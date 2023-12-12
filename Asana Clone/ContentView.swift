import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: Environment Variables
    @Environment(CloudKitManager.self) private var cloudKitManager
    @Environment(AsanaManager.self) private var asanaManager
    @Environment(\.modelContext) private var modelContext
    
    // MARK: Data
    @Query private var teams: [TeamModel]
    @Query private var members: [MemberModel]
    
    // MARK: State Variables
    @State private var colorScheme: ColorScheme = .white
    @State private var showInspector: Bool = false
    @State private var showTeamModal: Bool = false
    @State private var showMemberModal: Bool = false
    @State private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        
        if cloudKitManager.isSignedInToiCloud && !teams.isEmpty && !members.isEmpty {
            NavigationSplitView(columnVisibility: $columnVisibility, sidebar: {
                SidebarView()
            }, detail: {
                ContentDetail()
                    .inspector(isPresented: Binding(get: {
                        return asanaManager.showHomeCustomization
                    }, set: { newValue in
                        asanaManager.showHomeCustomization = newValue
                    })) {
                        HomeInspector(colorScheme: $colorScheme)
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Menu {
                                Section {
                                    Button {
                                        if let currentMember = asanaManager.currentMember {
                                            let task = TaskModel(name: "Test", assignee: currentMember)
                                            modelContext.insert(task)
                                        }
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
            .sheet(item: $asanaManager.selectedTask) { task in
                TaskDetailView(task)
            }
            .onAppear {
                asanaManager.currentTeam = teams[0]
            }
        } else {
            if !cloudKitManager.error.isEmpty {
                ContentUnavailableView(cloudKitManager.error, image: "exclamationmark.triangle.fill")
                
            } else if members.isEmpty {
                SignupView()
            } else if teams.isEmpty {
                ContentUnavailableView("No teams created", systemImage: "person.2.slash")
                    .sheet(isPresented: .constant(true), content: {
                        NewTeamModal()
                    })
                
                Button("Make team") {
                    showTeamModal.toggle()
                }
                .buttonStyle(.bordered)
                .tint(.white)
                .foregroundStyle(.primary)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.primary, lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                ContentUnavailableView(cloudKitManager.error, image: "exclamationmark.triangle.fill")
            }
        }
    }
}

#Preview {
    @State var cloudKitManager = CloudKitManager()
    @State var asanaManager = AsanaManager()
    
    return ContentView()
        .environment(cloudKitManager)
        .environment(asanaManager)
        
}

