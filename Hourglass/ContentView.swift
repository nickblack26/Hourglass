import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: Environment Variables
    @Environment(HourglassManager.self) private var hourglass
	@Environment(\.modelContext) private var context
	
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
		.onAppear {
			print(context)
		}
    }
}

#Preview {
    @State var hourglass = HourglassManager()
    
    return ContentView()
        .environment(hourglass)
        
}

