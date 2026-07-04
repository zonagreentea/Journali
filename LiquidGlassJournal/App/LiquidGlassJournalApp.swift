import SwiftUI

@main
struct LiquidGlassJournalApp: App {
    // John Appleseed placeholders:
    // Replace with your Team ID & Bundle IDs in Xcode project settings

    @StateObject private var persistenceController = PersistenceController.shared
    @StateObject private var auth = LoTAuth.shared

    var body: some Scene {
        WindowGroup {
            EntryListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(auth)
        }
    }
}
