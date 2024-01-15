import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: Environment Variables
    @Environment(AsanaManager.self) private var asanaManager
    
    // MARK: State Variables
    @State private var colorScheme: ColorScheme = .white
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        
        NavigationSplitView(
            columnVisibility: $asanaManager.columnVisibility,
            sidebar: {
                SidebarView()
            }, detail: {
                NavigationStack {
                    ContentDetail()
//                        .toolbar(.hidden)
                        .inspector(isPresented: $asanaManager.showHomeCustomization) {
                            HomeInspector(colorScheme: $colorScheme)
                        }
                }
            }
        )
    }
}

#Preview {
    @State var asanaManager = AsanaManager()
    
    return ContentView()
        .environment(asanaManager)
        
}

