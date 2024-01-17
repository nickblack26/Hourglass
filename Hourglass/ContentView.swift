import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: Environment Variables
    @Environment(HourglassManager.self) private var hourglass
	@Environment(\.modelContext) private var context
    
    var body: some View {
        @Bindable var hourglass = hourglass
        
        NavigationSplitView(
            columnVisibility: $hourglass.columnVisibility,
            sidebar: {
                SidebarView()
            }, detail: {
                NavigationStack {
                    ContentDetail()
                }
            }
        )
    }
}

#Preview {
    @State var hourglass = HourglassManager()
    
    return ContentView()
        .environment(hourglass)
        
}

