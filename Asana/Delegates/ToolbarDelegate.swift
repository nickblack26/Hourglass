//
//  ToolbarDelegate.swift
//  Asana
//
//  Created by Nick Black on 1/8/24.
//

import UIKit

class ToolbarDelegate: NSObject {
    
}

#if targetEnvironment(macCatalyst)
extension NSToolbarItem.Identifier {
    static let backButton = NSToolbarItem.Identifier("com.nicholasblack.Asana.backButton")
    static let forwardButton = NSToolbarItem.Identifier("com.nicholasblack.Asana.forwardButton")
    static let globalSearch = NSToolbarItem.Identifier("com.nicholasblack.Asana.customSearchBar")
    static let editRecipe = NSToolbarItem.Identifier("com.nicholasblack.Asana.editRecipe")
}

extension ToolbarDelegate: NSToolbarDelegate {
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        let identifiers: [NSToolbarItem.Identifier] = [
            .toggleSidebar,
            .primarySidebarTrackingSeparatorItemIdentifier,
//            .space,
            .backButton,
            .primarySidebarTrackingSeparatorItemIdentifier,
            .forwardButton,
            .primarySidebarTrackingSeparatorItemIdentifier,
            .cloudSharing,
            .flexibleSpace,
            .globalSearch,
            .flexibleSpace,
            .editRecipe
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
            
            let item = NSToolbarItem(itemIdentifier: itemIdentifier)
            
            item.label = "Toggle Favorite"
            //                        item.action = #selector(RecipeDetailViewController.toggleFavorite(_:))
            item.target = nil

            toolbarItem = item
        case .backButton:
            let item = NSToolbarItem(itemIdentifier: itemIdentifier)
            
            item.label = "Go back"
            item.image = UIImage(named: "chevron.left")
            //                        item.action = #selector(RecipeDetailViewController.toggleFavorite(_:))
            item.target = nil

            toolbarItem = item
        case .forwardButton:
            let item = NSToolbarItem(itemIdentifier: itemIdentifier)
            
            item.label = "Go forward"
            item.image = UIImage(named: "chevron.right")
            //                        item.action = #selector(RecipeDetailViewController.toggleFavorite(_:))
            item.target = nil

            toolbarItem = item
        default:
            toolbarItem = nil
        }
        
        return toolbarItem
    }
    
}
#endif
