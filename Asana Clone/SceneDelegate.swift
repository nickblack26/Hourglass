import UIKit

class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
#if targetEnvironment(macCatalyst)
		if let titlebar = windowScene.titlebar {
			titlebar.titleVisibility = .hidden
			titlebar.toolbar = nil
		}
#endif
		
	}
}
