import Foundation
import CoreData
import CloudKit

final class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer

    private init(inMemory: Bool = false) {
        // Placeholder CloudKit container identifier for John Appleseed
        let containerIdentifier = "iCloud.com.johnappleseed.journali"
        container = NSPersistentCloudKitContainer(name: "LiquidGlassJournal")

        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("No persistent store description found")
        }

        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

        if inMemory {
            description.url = URL(fileURLWithPath: "/dev/null")
        }

        // Configure CloudKit container (placeholder)
        description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: containerIdentifier)

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // Replace this with proper error handling
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
