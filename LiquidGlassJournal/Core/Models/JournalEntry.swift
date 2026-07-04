import Foundation
import SwiftUI

// Simple model for previews and cross-platform sharing. In the full project
// a Core Data NSManagedObject model is recommended. This struct is used
// by the web adapter and quick previews.

public struct JournalEntry: Identifiable, Codable {
    public var id: UUID = UUID()
    public var timestamp: Date = Date()
    public var title: String = ""
    public var text: String = ""
    public var tags: [String] = []
    public var mood: String? = nil

    // AI fields (optional)
    public var aiSummary: String? = nil
    public var aiInsights: [String] = []

    public init() {}
}
