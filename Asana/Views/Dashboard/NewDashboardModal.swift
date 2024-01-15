import SwiftUI

struct NewDashboardModal: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AsanaManager.self) private var asana
	let columns = Array(repeating: GridItem(), count: 3)
    @Bindable var dashboard: Dashboard
	
    var body: some View {
		List {
            Section("Recommended") {
				LazyVGrid(columns: columns, content: {
                    Button {
                        dismiss()
                        asana.selectedChart = .init(name: "")
                    } label: {
						Image(systemName: "chart.bar.xaxis")
						Text("Add custom chart")
					}
					.padding()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.background {
						RoundedRectangle(cornerRadius: 10)
							.fill(.clear)
							.stroke(.secondary, style: StrokeStyle(lineWidth: 1, dash: [5]))
					}
					.foregroundStyle(.secondary)
				})
			}
			.headerProminence(.increased)
			.listRowSeparator(.hidden)
			
            Section("Resourcing") {
				LazyVGrid(columns: columns, content: {
//					ForEach(Chart.resourcingCharts()) { chart in
//						ChartSelector(title: chart.title, image: chart.image)
//					}
				})
			}
			.headerProminence(.increased)
			.listRowSeparator(.hidden)

			
            Section("Work health") {
				LazyVGrid(columns: columns, content: {
//					ForEach(Chart.workHealth()) { chart in
//						ChartSelector(title: chart.title, image: chart.image)
//					}
				})
			}
			.headerProminence(.increased)
			.listRowSeparator(.hidden)

			
            Section("Progress") {
				LazyVGrid(columns: columns, content: {
//					ForEach(Chart.progress()) { chart in
//						ChartSelector(title: chart.title, image: chart.image)
//					}
				})
			}
			.headerProminence(.increased)
			.listRowSeparator(.hidden)

		}
		.listStyle(.plain)
    }
}

#Preview {
	Text("hello")
		.sheet(isPresented: .constant(true), content: {
			NavigationView {
                NewDashboardModal(dashboard: .init(name: ""))
			}
		})
}
