import SwiftUI
import SwiftData

struct ReportingView: View {
    @State private var isExpanded: Bool = true
    @Environment(HourglassManager.self) private var asana
    
    // Get all dashboards not tied to a project
    @Query(
        filter: #Predicate<Dashboard> { $0.project == nil }
    )
    private var dashboards: [Dashboard]
    
    var body: some View {
        List {
            Section(
                "Recents",
                isExpanded: $isExpanded
            ) {
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(),
                        count: 2
                    ),
                    alignment: .leading,
                    spacing: 24
                ) {
                    ForEach(dashboards) { dashboard in
                        Card(.constant(false)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(dashboard.icon.image)
                                        .padding()
                                        .background(
                                            dashboard.color.color,
                                            in: .rect(cornerRadius: 8)
                                        )
                                    Text(dashboard.name)
                                }
                            }
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)
            .headerProminence(.increased)
        }
        .listStyle(.plain)
        .navigationTitle("Reporting")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Create dashboard", systemImage: "plus") {
                    asana.selectedDashboard = .init(name: "")
                }
            }
        }
    }
}

#Preview {
    @State var hourglass = HourglassManager()
    
    return NavigationStack {
        ReportingView()
    }
    .environment(hourglass)
    .modelContainer(for: Dashboard.self)
}
