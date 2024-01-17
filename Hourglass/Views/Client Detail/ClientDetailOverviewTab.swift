import SwiftUI

struct ClientDetailOverviewTab: View {
    @Bindable var client: Client
    
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
                        Text("Contacts (\(client.contacts.count))")
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
                            
                            ForEach(client.contacts) { contact in
                                HStack {
                                    AvatarView(
                                        image: nil,
                                        fallback: contact.name,
                                        size: .tiny
                                    )
                                    
                                    VStack(alignment: .leading) {
                                        Text(contact.name)
                                        Text(contact.phone ?? "")
                                    }
                                }
                            }
                        }
                    }
                }
                .gridCellUnsizedAxes(.vertical)
            }
        }
    }
}

#Preview {
    ClientDetailOverviewTab(client: .init(name: ""))
}
