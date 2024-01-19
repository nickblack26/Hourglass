import SwiftUI

private enum ClientTab: String, CaseIterable {
    case overview
    case projects
    case invoices
    case subscriptions
    case transactions
}

struct ClientDetailView: View {
    @State private var selectedTab: ClientTab = .overview
    @Bindable var client: Client
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ClientDetailOverviewTab(client: client)
                .tag(ClientTab.overview)
        }
        .padding()
        .toolbar {
            
        }
        .toolbarRole(.editor)
        .navigationTitle($client.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ClientDetailView(client: .init(name: ""))
}
