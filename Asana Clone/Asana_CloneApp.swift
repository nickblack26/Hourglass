import SwiftUI
import SwiftData

@main
struct Asana_CloneApp: App {
	@UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
	
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: TeamModel.self)
        }
    }
}
