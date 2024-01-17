import Foundation
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: fullSchema,
            configurations: .init(isStoredInMemoryOnly: true)
        )
 
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
