import UIKit
import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    var window: UIWindow?
    var toolbarDelegate = ToolbarDelegate()
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        
#if targetEnvironment(macCatalyst)
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let toolbar = NSToolbar(identifier: "main")
        toolbar.delegate = toolbarDelegate
        toolbar.displayMode = .iconOnly
        
        if let titlebar = windowScene.titlebar {
            titlebar.toolbar = toolbar
            titlebar.toolbarStyle = .unifiedCompact
        }
#endif
    }
}
