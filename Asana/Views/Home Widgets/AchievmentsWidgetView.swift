import SwiftUI

enum OverviewDate: String, CaseIterable {
	case week = "My Week"
	case month = "My Month"
}

struct AchievmentsWidgetView: View {
	@State private var viewDate: OverviewDate = .week
	let number: (Int, Int)
	let collaborators: Int
	
    var body: some View {
		HStack {
			Picker("My Week", selection: $viewDate) {
				ForEach(OverviewDate.allCases, id: \.rawValue) { overview in
					Text(overview.rawValue)
						.tag(overview)
				}
			}
			.tint(.primary)
			
			Divider()
				.frame(maxHeight: 35)
			
			Label {
				HStack {
                    Text("\(viewDate == .week ? number.0 : number.1)")
						.font(.title)
						.fontWeight(.bold)
					
                    Text("\(number.0 == 1 || number.1 == 1 ? "task" : "tasks") completed")
				}
			} icon: {
				Image(systemName: "checkmark")
			}
			.padding(.horizontal)
			
			Label {
				HStack {
					Text("\(collaborators)")
						.font(.title)
						.fontWeight(.bold)
					
					Text("\(collaborators == 1 ? "collaborator" : "collaborators")")
				}
			} icon: {
				Image(systemName: "person.2")
			}
			.padding(.horizontal)
		}
		.padding(.horizontal)
		.padding(.vertical, 10)
		.background(.grayAccent)
		.foregroundStyle(.secondary)
		.clipShape(Capsule())
    }
}

#Preview {
	AchievmentsWidgetView(number: (2,1), collaborators: 1)
}
