import SwiftUI

struct ContentDetail: View {
    @Environment(AsanaManager.self) private var asanaManager
	
    var body: some View {
        switch asanaManager.selectedLink {
			case .home:
				HomeView()
			case .myTasks:
                MyTasksView()
            case .transactions:
				TransactionsOverviewView()
			case .inbox:
				InboxView()
			case .reporting:
				ReportingView()
			case .portfolios:
				PortfolioView()
			case .goals:
				GoalView()
			case .project(let project):
				ProjectView(project)
            case .client(let client):
                Text(client.name)
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
    @State var asana = AsanaManager()
    
	return ContentDetail()
        .environment(asana)
}
