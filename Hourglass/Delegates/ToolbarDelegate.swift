#if canImport(UIKit)
import UIKit
#endif
import Foundation
import SwiftUI

class ToolbarDelegate: NSObject  {
    
}



#if targetEnvironment(macCatalyst)
extension NSToolbarItem.Identifier {
    static let backButton = NSToolbarItem.Identifier("com.nicholasblack.Hourglass.backButton")
    static let forwardButton = NSToolbarItem.Identifier("com.nicholasblack.Hourglass.forwardButton")
    static let globalSearch = NSToolbarItem.Identifier("com.nicholasblack.Hourglass.customSearchBar")
    static let editRecipe = NSToolbarItem.Identifier("com.nicholasblack.Hourglass.editRecipe")
}

extension ToolbarDelegate: NSToolbarDelegate {
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        let identifiers: [NSToolbarItem.Identifier] = [
            .toggleSidebar,
            .primarySidebarTrackingSeparatorItemIdentifier,
//            .space,
//            .backButton,
//            .forwardButton,
//            .cloudSharing,
//            .flexibleSpace,
//            .editRecipe
        ]
        return identifiers
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarDefaultItemIdentifiers(toolbar)
    }
    
    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        var toolbarItem: NSToolbarItem?
        
        switch itemIdentifier {
        case .editRecipe:
            let item = NSToolbarItem(itemIdentifier: itemIdentifier)
            let image = UIImage(systemName: "square.and.pencil")
            
            item.image = image
            item.label = "Edit Recipe"
            //                       item.action = #selector(RecipeDetailViewController.editRecipe(_:))
            item.target = nil
            toolbarItem = item
        case .globalSearch:
//            let view = UIHostingController(rootView: CustomToolbarItem(image: "chevron.left"))
            let item = NSToolbarItem(
                itemIdentifier: itemIdentifier
//                barButtonItem: UIBarButtonItem(customView: view.view)
            )
            item.image = .init(named: "chevron.left")
            item.label = "Go back"
            item.target = nil
            
            toolbarItem = item
        case .backButton:
//            let view = UIHostingController(rootView: CustomToolbarItem(image: "chevron.left"))
            let item = NSToolbarItem(
                itemIdentifier: itemIdentifier
//                barButtonItem: UIBarButtonItem(customView: view.view)
            )
            item.image = .init(named: "chevron.left")

            item.label = "Go back"
            item.target = nil
            
            toolbarItem = item
        case .forwardButton:
//            let view = UIHostingController(rootView: CustomToolbarItem(image: "chevron.right"))
            let item = NSToolbarItem(
                itemIdentifier: itemIdentifier
//                barButtonItem: UIBarButtonItem(customView: view.view)
            )
            item.image = .init(named: "chevron.right")
            item.label = "Go forward"
            item.target = nil
            toolbarItem = item
        default:
            toolbarItem = nil
        }
        
        return toolbarItem
    }
    
}
#endif
