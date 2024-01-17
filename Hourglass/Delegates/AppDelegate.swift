import UIKit
import CoreData
import SwiftData
import CloudKit

class AppDelegate: NSObject, UIApplicationDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		
		return true
	}
			
	var container: NSPersistentContainer = .init(name: "Hourglass", managedObjectModel: .init().makeManagedObjectModel(for: fullSchema)!)
	
	lazy var persistentContainer: NSPersistentCloudKitContainer = {
		let container = NSPersistentCloudKitContainer(name: "Hourglass")
		
		// Create a store description for a local store
		let localStoreLocation = URL(fileURLWithPath: "/files/local.sqlite")
		let localStoreDescription =
		NSPersistentStoreDescription(url: localStoreLocation)
		localStoreDescription.configuration = "Local"
		
		// Create a store description for a CloudKit-backed local store
		let cloudStoreLocation = URL(fileURLWithPath: "/files/cloud.sqlite")
		let cloudStoreDescription =
		NSPersistentStoreDescription(url: cloudStoreLocation)
		cloudStoreDescription.configuration = "Cloud"
		
		
		// Set the container options on the cloud store
		cloudStoreDescription.cloudKitContainerOptions =
		NSPersistentCloudKitContainerOptions(
			containerIdentifier: "iCloud.com.nicholasblack.Hourglass")
		
		// Update the container's list of store descriptions
		container.persistentStoreDescriptions = [
			cloudStoreDescription,
			localStoreDescription
		]
		
		// Load both stores
		container.loadPersistentStores { storeDescription, error in
			guard error == nil else {
				fatalError("Could not load persistent stores. \(error!)")
			}
		}
		
		return container
	}()
    
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
		configuration.delegateClass = SceneDelegate.self
        
        
		return configuration
	}
}
