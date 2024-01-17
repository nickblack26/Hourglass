import SwiftUI
import SwiftData

struct ReportingView: View {
    @Environment(HourglassManager.self) private var asana
    
    // Get all dashboards not tied to a project
    @Query(
        filter: #Predicate<Dashboard> { $0.project == nil }
    )
    private var dashboards: [Dashboard]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Reporting")
                .font(.largeTitle)
            
            Button("Create", systemImage: "plus") {
                asana.selectedDashboard = .init(name: "")
            }
            .buttonStyle(.borderedProminent)
            
            Section("Recents") {
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
            .headerProminence(.increased)
            .padding(.horizontal)
        }
        .padding()
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

#Preview {
    NavigationStack {
        ReportingView()
    }
    .modelContainer(for: Dashboard.self)
}
