import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: Environment Variables
    @Environment(CloudKitManager.self) private var cloudKitManager
    @Environment(AsanaManager.self) private var asanaManager
    @Environment(\.modelContext) private var modelContext
    
    // MARK: Data
    @Query private var teams: [Team]
    
    // MARK: State Variables
    @State private var colorScheme: ColorScheme = .white
    @State private var showInspector: Bool = false
    @State private var showTeamModal: Bool = false
    @State private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        
        NavigationSplitView(
            columnVisibility: $asanaManager.columnVisibility,
            sidebar: {
                SidebarView()
            }, detail: {
                NavigationStack {
                    ContentDetail()
                        .toolbar(.hidden)
                        .inspector(isPresented: $asanaManager.showHomeCustomization) {
                            HomeInspector(colorScheme: $colorScheme)
                        }
                }
            }
        )
    }
}

#Preview {
    @State var cloudKitManager = CloudKitManager()
    @State var asanaManager = AsanaManager()
    
    return ContentView()
        .environment(cloudKitManager)
        .environment(asanaManager)
        
}

