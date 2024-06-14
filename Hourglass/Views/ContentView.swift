import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: Environment Variables
    @Environment(HourglassManager.self) private var hourglass
    
    var body: some View {
        @Bindable var hourglass = hourglass
        
        NavigationSplitView(columnVisibility: $hourglass.columnVisibility) {
            SidebarView()
        } detail: {
            NavigationStack {
                ContentDetail()
            }
        }
    }
}

#Preview {
    @Previewable @State var hourglass = HourglassManager()
    
    ContentView()
        .environment(hourglass)
        .frame(minWidth: 1000, minHeight: 1000)
}

