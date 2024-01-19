import Foundation
import Contacts

class ContactManager {
    static let shared = ContactManager()
    
    private let store = CNContactStore()
    var isAuthorized: Bool = false
    
    init() {
        getAuthorizationStatus()
    }
    
    func fetchContacts(client: String) -> [CNContact] {
        do {
            // find contacts by their organization name
            let predicate = CNContact.predicateForContacts(matchingName: client)
            
            // fetch these specific keys
            let keys: [CNKeyDescriptor] = [
                CNContactIdentifierKey as CNKeyDescriptor,
                CNContactGivenNameKey as CNKeyDescriptor,
                CNContactFamilyNameKey as CNKeyDescriptor,
                CNContactEmailAddressesKey as CNKeyDescriptor,
                CNContactPhoneNumbersKey as CNKeyDescriptor,
                CNContactImageDataKey as CNKeyDescriptor,
                CNContactThumbnailImageDataKey as CNKeyDescriptor,
                CNContactImageDataAvailableKey as CNKeyDescriptor
            ]
            
            return try store.unifiedContacts(matching: predicate, keysToFetch: keys)
        } catch {
            print("Error on contact fetching \(error)")
            return []
        }
    }
    
    func createContact(
        givenName: String,
        familyName: String,
        email: String,
        phoneNumber: String?,
        organization: String
    ) {
        // Create a mutable object to add to the contact.
        let contact = CNMutableContact()

        contact.givenName = givenName
        contact.familyName = familyName
        contact.organizationName = organization
 
        let workEmail = CNLabeledValue(label: CNLabelWork, value: email as NSString)
        contact.emailAddresses = [workEmail]

        if let phoneNumber {
            contact.phoneNumbers = [CNLabeledValue(
                label: CNLabelPhoneNumberMain,
                value: CNPhoneNumber(stringValue: phoneNumber))]
        }

        // Save the newly created contact.
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        
        saveRequest.add(contact, toContainerWithIdentifier: nil)

        do {
            try store.execute(saveRequest)
        } catch {
            print("Saving contact failed, error: \(error)")
            // Handle the error.
        }
    }
    
    private func getAuthorizationStatus() {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            self.isAuthorized = true
        case .denied:
            print ("denied")
        case .notDetermined:
            print ("notDetermined")
            requestAuthorization()
        case .restricted:
            print ("restricted")
        @unknown default:
            print ("")
        }
    }
    
    private func requestAuthorization() {
        store.requestAccess(for: .contacts) { granted, error in
            if granted {
                self.isAuthorized = true
            } else if let error = error {
                print("Error requesting contact access: \(error)")
            }
        }
    }
}
