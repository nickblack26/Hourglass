//
//  NewDashboardModal.swift
//  Asana Clone
//
//  Created by Nick on 7/10/23.
//

import SwiftUI

struct NewDashboardModal: View {
	let columns = Array(repeating: GridItem(), count: 3)
	
    var body: some View {
		List {
            SwiftUI.Section("Recommended") {
				LazyVGrid(columns: columns, content: {
					VStack {
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
					
					ForEach(Chart.recommendedCharts()) { chart in
						ChartSelector(title: chart.title, image: chart.image)
					}
				})
			}
			.headerProminence(.increased)
			.listRowSeparator(.hidden)
			
            SwiftUI.Section("Resourcing") {
				LazyVGrid(columns: columns, content: {
					ForEach(Chart.resourcingCharts()) { chart in
						ChartSelector(title: chart.title, image: chart.image)
					}
				})
			}
			.headerProminence(.increased)
			.listRowSeparator(.hidden)

			
            SwiftUI.Section("Work health") {
				LazyVGrid(columns: columns, content: {
					ForEach(Chart.workHealth()) { chart in
						ChartSelector(title: chart.title, image: chart.image)
					}
				})
			}
			.headerProminence(.increased)
			.listRowSeparator(.hidden)

			
            SwiftUI.Section("Progress") {
				LazyVGrid(columns: columns, content: {
					ForEach(Chart.progress()) { chart in
						ChartSelector(title: chart.title, image: chart.image)
					}
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
				NewDashboardModal()
			}
		})
}
