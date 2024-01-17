import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: Environment Variables
    @Environment(HourglassManager.self) private var hourglass
    
    // MARK: State Variables
    @State private var colorScheme: ColorScheme = .white
    
    var body: some View {
        @Bindable var hourglass = hourglass
        
        NavigationSplitView(
            columnVisibility: $hourglass.columnVisibility,
            sidebar: {
                SidebarView()
            }, detail: {
                NavigationStack {
                    ContentDetail()
                        .inspector(isPresented: $hourglass.showHomeCustomization) {
                            HomeInspector(colorScheme: $colorScheme)
                        }
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

