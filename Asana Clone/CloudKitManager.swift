import Foundation
import Observation
import CloudKit
import SwiftData

@Observable
class CloudKitManager {
    var permissionStatus: Bool = false
    var isSignedInToiCloud: Bool = false
    var error: String = ""
    var userName: String = ""
    
    init() {
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordId()
    }
    
    private func getiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.localizedDescription
                case .available:
                    self?.isSignedInToiCloud = true
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.localizedDescription
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.localizedDescription
                case .temporarilyUnavailable:
                    self?.error = CloudKitError.iCloudAccountUnknown.localizedDescription
                @unknown default:
                    self?.error = CloudKitError.iCloudAccountUnknown.localizedDescription
                }
            }
        }
    }
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] status, error in
            DispatchQueue.main.async {
                if status == .granted {
                    self?.permissionStatus = true
                }
            }
        }
    }
    
    func fetchiCloudUserRecordId() {
        CKContainer.default().fetchUserRecordID { [weak self] id, error in
            if let id {
                self?.getiCloudUser(id: id)
            }
        }
    }
    
    func getiCloudUser(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] identity, error in
            DispatchQueue.main.async {
                if let name = identity?.nameComponents?.givenName {
                    self?.userName = name
                }
            }
        }
    }
    
    enum CloudKitError: LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
}
