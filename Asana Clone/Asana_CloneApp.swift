import SwiftUI

@main
struct Asana_CloneApp: App {
	@UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
	@State private var vm = UserDefaultsViewModel()
	@State private var manager = SupabaseManger()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.tint(Color("brand"))
				.background(Color("AppBG"))
				.environment(vm)
				.environment(manager)
        }
    }
}
