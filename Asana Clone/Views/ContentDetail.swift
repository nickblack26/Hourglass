import SwiftUI

struct ContentDetail: View {
    @Environment(AsanaManager.self) private var asanaManager
	
    var body: some View {
        switch asanaManager.selectedLink {
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
			case .project(let project):
				ProjectView(project)
			case .team(_):
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

#Preview {
	ContentDetail()
}
