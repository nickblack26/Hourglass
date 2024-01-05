import CoreData
import SwiftData

public extension ModelContext {
    // Computed property to access the underlying NSManagedObjectContext
    var managedObjectContext: NSManagedObjectContext? {
        guard let managedObjectContext = getMirrorChildValue(of: self, childName: "_nsContext") as? NSManagedObjectContext else {
            return nil
        }
        return managedObjectContext
    }

    // Computed property to access the NSPersistentStoreCoordinator
    var coordinator: NSPersistentStoreCoordinator? {
        managedObjectContext?.persistentStoreCoordinator
    }
}

func getMirrorChildValue(of object: Any, childName: String) -> Any? {
    guard let child = Mirror(reflecting: object).children.first(where: { $0.label == childName }) else {
        return nil
    }

    return child.value
}
