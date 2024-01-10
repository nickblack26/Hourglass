import Foundation
import Observation
import CloudKit
import SwiftData
import SwiftUI

@Observable
class CloudKitManager {
    var database: CKDatabase = CKContainer.default().privateCloudDatabase
    var container: CKContainer = CKContainer.default()
    var permissionStatus: Bool = false
    var isSignedInToiCloud: Bool = false
    var error: String = ""
    var userName: String = ""
    
    init() {
//        let shared = CKContainer.default().sharedCloudDatabase
//        shared.acceptShare
        SwiftUI.Task {
            try? await getUserInformation()
            
        }
    }
    
    func getUserInformation() async throws -> (id: String, name: String) {
        do {
            let recordID = try await container.userRecordID()
            let id = recordID.recordName
            
            let participant = try await container.shareParticipant(forUserRecordID: recordID)
            guard let nameComponents = participant.userIdentity.nameComponents else {
                throw CloudKitError.iCloudAccountUnknown
            }
            let name = PersonNameComponentsFormatter().string(from: nameComponents)
            userName = name
            return (id, name)
        } catch {
            throw error
        }
    }
    
    func createShare(record: CKRecord) async throws -> CKShare {
        let share = CKShare(rootRecord: record)
//        container.share
        
        let _ = try await database.modifyRecords(saving: [record, share], deleting: [])
        
        return share
    }
    
    enum CloudKitError: LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
}
