//
//  ContentDetail.swift
//  Asana Clone
//
//  Created by Nick on 7/10/23.
//

import SwiftUI

struct ContentDetail: View {
	@Binding var selectedLink: SidebarLink?
	
    var body: some View {
		ScrollView {
			switch selectedLink {
				case .home:
					HomeView()
				case .myTasks:
					MyTasksView()
				case .inbox:
					InboxView()
				case .reporting:
					DashboardView()
				case .portfolios:
					PortfolioView()
				case .goals:
					GoalView()
				case .project(let uuid):
					ProjectView(project_id: uuid)
				case .team(_):
					//						TeamView(id: uuid)
					TeamView()
				case nil:
					ContentUnavailableView {
						Image(systemName: "magnifyingglass.circle")
					} description: {
						Text("Select a suspect to inspect")
					} actions: {
						Text("Fill out details from the interview")
					}
			}
		}
    }
}

#Preview {
	ContentDetail(selectedLink: .constant(.home))
}
