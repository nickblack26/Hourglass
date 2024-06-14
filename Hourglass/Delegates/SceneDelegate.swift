#if os(iOS)
import UIKit
import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
//    var window: UIWindow?
//    var toolbarDelegate = ToolbarDelegate()
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        #if targetEnvironment(macCatalyst)
        if let titlebar = windowScene.titlebar {
            titlebar.titleVisibility = .hidden
            titlebar.toolbar = nil
        }
        #endif
    }
}
#endif
