import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: Environment Variables
    @Environment(HourglassManager.self) private var hourglass
    
    // MARK: State Variables
    @State private var colorScheme: ColorScheme = .white
    
    var body: some View {
        @Bindable var asanaManager = hourglass
        
        NavigationSplitView(
            columnVisibility: $asanaManager.columnVisibility,
            sidebar: {
                SidebarView()
            }, detail: {
                NavigationStack {
                    ContentDetail()
                        .inspector(isPresented: $asanaManager.showHomeCustomization) {
                            HomeInspector(colorScheme: $colorScheme)
                        }
                }
            }
        )
    }
}

#Preview {
    @State var asanaManager = HourglassManager()
    
    return ContentView()
        .environment(asanaManager)
        
}

