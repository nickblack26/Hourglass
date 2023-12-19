import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: Environment Variables
    @Environment(CloudKitManager.self) private var cloudKitManager
    @Environment(AsanaManager.self) private var asanaManager
    @Environment(\.modelContext) private var modelContext
    
    // MARK: Data
    @Query private var teams: [Team]
    @Query private var members: [Member]
    
    // MARK: State Variables
    @State private var colorScheme: ColorScheme = .white
    @State private var showInspector: Bool = false
    @State private var showTeamModal: Bool = false
    @State private var showMemberModal: Bool = false
    @State private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        
        if cloudKitManager.isSignedInToiCloud && !teams.isEmpty && !members.isEmpty {
            NavigationSplitView(
                columnVisibility: $asanaManager.columnVisibility, 
                sidebar: {
                    SidebarView()
                        .toolbar(removing: .sidebarToggle)
                }, detail: {
                    ContentDetail()
                        .toolbar(.hidden)
                        .inspector(isPresented: $asanaManager.showHomeCustomization) {
                            HomeInspector(colorScheme: $colorScheme)
                        }
                }
            )
            
            .sheet(item: $asanaManager.selectedTask) { task in
                TaskDetailView(task)
            }
            .onAppear {
                asanaManager.currentTeam = teams[0]
                asanaManager.currentMember = members[0]
            }
        } else {
            if !cloudKitManager.error.isEmpty {
                ContentUnavailableView(cloudKitManager.error, systemImage: "exclamationmark.triangle.fill")
                
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
                ContentUnavailableView(cloudKitManager.error, systemImage: "exclamationmark.triangle.fill")
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

