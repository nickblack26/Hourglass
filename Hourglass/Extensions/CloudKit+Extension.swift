import Foundation
import CloudKit
import CoreTransferable

extension CKShare.ParticipantAcceptanceStatus {
    var stringValue: String {
        return ["Unknown", "Pending", "Accepted", "Removed"][rawValue]
    }
}

extension CKShare {
    var title: String {
        guard let date = creationDate else {
            return "\(UUID().uuidString)"
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

