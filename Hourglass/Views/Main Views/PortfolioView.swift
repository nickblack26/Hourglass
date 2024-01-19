import SwiftUI

fileprivate enum ViewStyle: String, CaseIterable {
    case tile
    case list
    
    var icon: String {
        switch self {
        case .tile:
            "rectangle.grid.2x2"
        case .list:
            "list.dash"
        }
    }
}

struct PortfolioView: View {
    @State private var isExpanded: Bool = true
    @State private var selectedView: ViewStyle = .tile
    
    var body: some View {
        List {
            Section(
                "Recent portfolios",
                isExpanded: $isExpanded
            ) {
                switch selectedView {
                case .tile:
                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(),
                            count: 2
                        ),
                        alignment: .leading,
                        spacing: 24
                    ) {
                        
                    }
                case .list:
                    EmptyView()
                }
            }
            .listRowSeparator(.hidden)
            .headerProminence(.increased)

        }
        .listStyle(.plain)
        .navigationTitle("Reporting")
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Menu("Select view", systemImage: selectedView.icon) {
                    Picker("Select view", systemImage: selectedView.icon, selection: $selectedView) {
                        ForEach(ViewStyle.allCases, id: \.self) { style in
                            Text("View as \(style.rawValue)")
                                .tag(style)
                        }
                    }
                }
                
                Button("Create dashboard", systemImage: "plus") {
                    
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PortfolioView()
    }
}
