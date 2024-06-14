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
        .toolbarRole(.editor)
        .navigationTitle($client.name)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    ClientDetailView(client: .init(name: ""))
}
