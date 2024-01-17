import CoreData
import SwiftData
import CloudKit


public extension ModelContext {
	// Computed property to access the underlying NSManagedObjectContext
	var managedObjectContext: NSManagedObjectContext? {
		guard let managedObjectContext = getMirrorChildValue(of: self, childName: "_nsContext") as? NSManagedObjectContext else {
			print("MANAGED OBJECT CONTEXT")
			return nil
		}
		print("MANAGED OBJECT CONTEXT", managedObjectContext)
		return managedObjectContext
	}
	
	
	
	// Computed property to access the NSPersistentStoreCoordinator
	var coordinator: NSPersistentStoreCoordinator? {
		managedObjectContext?.persistentStoreCoordinator
	}
}

func getMirrorChildValue(of object: Any, childName: String) -> Any? {
	print("RUNING MODEL CONTEXT EXTENSION")
    guard let child = Mirror(reflecting: object).children.first(where: { $0.label == childName }) else {
        return nil
    }

    return child.value
}

extension ModelContext {
    func existingModel<T>(for objectID: PersistentIdentifier)
    throws -> T? where T: PersistentModel {
        if let registered: T = registeredModel(for: objectID) {
            return registered
        }
        
        let fetchDescriptor = FetchDescriptor<T>(
            predicate: #Predicate {
                $0.persistentModelID == objectID
            })
        
        return try fetch(fetchDescriptor).first
    }
	
//	func shareObject(
//		_ unsharedObject: NSManagedObject,
//		to existingShare: CKShare?,
//		completionHandler: (
//			(
//				_ share: CKShare?,
//				_ error: Error?
//			) -> Void
//		)? = nil
//	) {
//	persistentContainer.share([unsharedObject], to: existingShare) { (objectIDs, share, container, error) in
//		guard error == nil, let share = share else {
//			print("\(#function): Failed to share an object: \(error!))")
//			completionHandler?(share, error)
//			return
//		}
//		/**
//		 Deduplicate tags because adding a photo to an existing share moves the entire object graph to the shared record zone,
//		 which can lead to duplicated tags.
//		 */
//		if existingShare != nil {
//			if let tagObjectIDs = objectIDs?.filter({ $0.entity.name == "Tag" }), !tagObjectIDs.isEmpty {
//				self.deduplicateAndWait(tagObjectIDs: Array(tagObjectIDs))
//			}
//		} else {
//			self.configure(share: share)
//		}
//		/**
//		 Synchronize the changes on the share to the private persistent store.
//		 */
//		self.persistentContainer.persistUpdatedShare(share, in: self.privatePersistentStore) { (share, error) in
//			if let error = error {
//				print("\(#function): Failed to persist updated share: \(error)")
//			}
//			completionHandler?(share, error)
//		}
//	}
//	}
}
