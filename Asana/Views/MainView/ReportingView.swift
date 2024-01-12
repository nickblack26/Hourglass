import SwiftUI
import SwiftData

struct ReportingView: View {
    @Environment(AsanaManager.self) private var asana
    @Query private var dashboards: [Dashboard]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Reporting")
                .font(.largeTitle)
            
            Button("Create", systemImage: "plus") {
                asana.selectedDashboard = .init(name: "")
//                asana.newDashboard.toggle()
            }
            .buttonStyle(.borderedProminent)
            
            SwiftUI.Section("Recents") {
                LazyVGrid(
                    columns: Array(repeating: GridItem(), count: 2),
                    alignment: .leading,
                    spacing: 24
                ) {
                    ForEach(dashboards) { dashboard in
                        Text(dashboard.name)
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
