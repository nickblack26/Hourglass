import SwiftUI
import SwiftData
import Contacts

struct ClientDetailOverviewTab: View {
    @State private var showActivity: Bool = false
    @State private var contacts: [CNContact] = []
//    let store = ContactManager.shared
    
    @Query private var allInvoices: [Invoice]
    @Query private var invoices: [Invoice]
    
    @Bindable var client: Client
    
    init(client: Client) {
        self.client = client
//        self._contacts = State(initialValue: store.fetchContacts(client: client.name))
        let clientId = client.persistentModelID
        self._invoices = Query(
            filter: #Predicate<Invoice> {
            $0.project != nil && $0.project?.client != nil && $0.project?.client?.id == clientId
            }
        )
    }
    
    var body: some View {
        Grid(horizontalSpacing: 16, verticalSpacing: 16) {
            GridRow(alignment: .top) {
                Card {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Total Revenue")
                            .font(.headline)
                        
                        FormattedCurrencyField(2040.00)
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                .gridCellUnsizedAxes(.vertical)
                
                Card {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("% of Total Revenue")
                            .font(.headline)
                        
                        DisclosureGroup {
                            
                        } label: {
                            Text(24, format: .percent)
                                .font(.title)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .gridCellUnsizedAxes(.vertical)
                
                Card {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Outstanding Invoices")
                            .font(.headline)
                        
                        Text("25")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                .gridCellUnsizedAxes(.vertical)
            }
            
            GridRow(alignment: .top) {
                Card {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Contacts (\(contacts.count))")
                            .font(.headline)
                        
                        LazyVGrid(
                            columns: Array(
                                repeating: GridItem(),
                                count: 3
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
                                    #if os(iOS)
                                    AvatarView(
                                        image: Image(
                                            uiImage: UIImage(data: contact.imageData ?? .init()) ?? .init()
                                        ),
                                        fallback: "\(contact.givenName) \(contact.familyName)",
                                        size: .small
                                    )
                                    #endif
                                    
                                    #if os(macOS)
                                    AvatarView(
                                        image: Image(
                                            nsImage: NSImage(data: contact.imageData ?? .init()) ?? .init()
                                        ),
                                        fallback: "\(contact.givenName) \(contact.familyName)",
                                        size: .small
                                    )
                                    #endif
                                    
                                    
                                    
                                    VStack(alignment: .leading) {
                                        Text("\(contact.givenName) \(contact.familyName)")
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                }
                .gridCellColumns(2)
                .gridCellUnsizedAxes(.vertical)
                
                Card {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("About")
                            .font(.headline)
                        
                        TextField(
                            "About",
                            text: .constant(""),
                            prompt: Text("Click to add client description..."),
                            axis: .vertical
                        )
                        .lineLimit(4, reservesSpace: true)
                    }
                }
                .gridCellUnsizedAxes(.vertical)
            }
            
            GridRow(alignment: .top) {
                Card {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recent Invoices")
                            .font(.headline)
                        
                        List {
                            Grid {
                                GridRow {
                                    HStack {
                                        Image(systemName: "doc")
                                        Text("Website Maintenance")
                                    }
                                    .gridCellColumns(2)
                                    
                                    FormattedCurrencyField(20240)
                                        .gridCellColumns(2)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .listRowBackground(EmptyView())
                        }
                        .listStyle(.plain)
                    }
                }
                .gridCellColumns(2)
                
                Card {
                    VStack(alignment: .leading) {
                        Text("Goals")
                            .font(.headline)
                        
                        
                    }
                    .frame(maxHeight: .infinity)
                }
//                .gridCellUnsizedAxes(.vertical)
            }
        }
        .padding(.horizontal)
        .toolbar(content: {
            ToolbarItem(placement: .primaryAction) {
                Button("Toggle Inspector", systemImage: "sidebar.trailing") {
                    showActivity.toggle()
                }
            }
        })
        .inspector(isPresented: $showActivity, content: {
            List {
                Section("Activity") {
                    
                }
            }
        })
//        .onChange(of: client) { oldValue, newValue in
//            self.contacts = store.fetchContacts(client: client.name)
//        }
    }
}

#Preview {
    let client = Client(name: "Plug Public Relations")
    previewContainer.mainContext.insert(client)
    
    return NavigationSplitView(columnVisibility: .constant(.detailOnly)) {
        
    } detail: {
        ClientDetailView(client: client)
            .modelContainer(previewContainer)
    }
}

struct AddressBuilderView: View {
    @Bindable var client: Client
    
    var body: some View {
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
                
                NumberField("Tax ID Number", value: Binding(value: $client.taxIdNumber))
                    .textFieldStyle(.roundedBorder)
                    .gridCellColumns(1)
            }
        }
    }
}
