import SwiftUI
import Contacts

struct ClientDetailOverviewTab: View {
    @State private var contacts: [CNContact] = []
    let store = ContactManager.shared

    @Bindable var client: Client
    
    init(client: Client) {
        self.client = client
        self._contacts = State(initialValue: store.fetchContacts(client: client.name))
    }
    
    var body: some View {
        Grid {
            GridRow {
                Card {
                    VStack(alignment: .leading) {
                        Text("Address")
                            .font(.title3)
                        
                        Grid {
                            GridRow {
                                TextField(
                                    "Address",
                                    text: Binding(value: $client.addressLine1)
                                )
                                .textFieldStyle(.roundedBorder)
                                .gridCellColumns(2)
                                
                                TextField(
                                    "Apt/Unit",
                                    text: Binding(value: $client.addressLine2)
                                )
                                .textFieldStyle(.roundedBorder)
                                .gridCellColumns(1)
                            }
                            
                            GridRow {
                                TextField(
                                    "City",
                                    text: Binding(value: $client.city)
                                )
                                .textFieldStyle(.roundedBorder)
                                .gridCellColumns(2)
                                
                                TextField(
                                    "Zip code",
                                    text: Binding(value: $client.postalCode)
                                )
                                .textFieldStyle(.roundedBorder)
                                .gridCellColumns(1)
                            }
                            
                            GridRow {
                                TextField(
                                    "Tax ID Label",
                                    text: Binding(value: $client.taxIdLabel)
                                )
                                .textFieldStyle(.roundedBorder)
                                .gridCellColumns(2)
                                
                                TextField(
                                    "Tax ID Number",
                                    value: Binding(value: $client.taxIdNumber),
                                    format: .number
                                )
                                .textFieldStyle(.roundedBorder)
                                .gridCellColumns(1)
                            }
                        }
                    }
                }
                
                Card {
                    VStack(alignment: .leading) {
						Text("Contacts (\(contacts.count))")
                            .font(.title3)
                        
                        LazyVGrid(
                            columns: Array(
                                repeating: GridItem(),
                                count: 2
                            ),
                            alignment: .leading
                        ) {
                            Button {
                                
                            } label: {
                                Image(systemName: "plus")
                                    .padding(8)
                                    .background {
                                        Circle()
                                            .fill(.clear)
                                            .strokeBorder(
                                                style: .init(
                                                    lineWidth: 1,
                                                    dash: [2]
                                                )
                                            )
                                    }
                                Text("Add member")
                                    .fontWeight(.medium)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.clear)
                            .foregroundStyle(.secondary)
                            
                            ForEach(contacts, id: \.identifier) { contact in
                                HStack {
                                    AvatarView(
                                        image: Image(
                                            uiImage: UIImage(data: contact.imageData ?? .init()) ?? .init()
                                        ),
                                        fallback: "\(contact.givenName) \(contact.familyName)",
                                        size: .small
                                    )
                                    
                                    VStack(alignment: .leading) {
                                        Text("\(contact.givenName) \(contact.familyName)")
//                                        Text(contact.familyName)
                                    }
                                }
                            }
                        }
                    }
                }
                .gridCellUnsizedAxes(.vertical)
            }
        }
		.inspector(
			isPresented: .constant(true)
		) {
            List {
				Section("Notifications") {}
				
				Section("Activites") {}
				
                Section("Contacts") {
                    ForEach(contacts, id: \.identifier) { contact in
                        HStack {
                            AvatarView(
                                image: contact.imageDataAvailable ? Image(uiImage: UIImage(data: contact.imageData ?? .init()) ?? .init()) : nil,
                                fallback: "\(contact.givenName) \(contact.familyName)",
                                size: .small
                            )
                            
                            VStack(alignment: .leading) {
                                Text("\(contact.givenName) \(contact.familyName)")
                            }
                        }
                    }
                }
            }
        }
        .onChange(of: client) { oldValue, newValue in
            self.contacts = store.fetchContacts(client: client.name)
        }
    }
}

#Preview {
    ClientDetailOverviewTab(client: .init(name: ""))
}
