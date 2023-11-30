//
//  AchievmentsWidgetView.swift
//  Asana Clone
//
//  Created by Nick on 6/26/23.
//

import SwiftUI

enum OverviewDate: String, CaseIterable {
	case week = "My Week"
	case month = "My Month"
}

struct AchievmentsWidgetView: View {
	@State private var viewDate: OverviewDate = .week
	let number: Int
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
					Text("\(number)")
						.font(.title)
						.fontWeight(.bold)
					
					Text("\(number == 1 ? "task" : "tasks") completed")
				}
			} icon: {
				Image(systemName: "checkmark")
			}
			.padding(.horizontal)
			
			Label {
				HStack {
					Text("\(number)")
						.font(.title)
						.fontWeight(.bold)
					
					Text("\(number == 1 ? "collaborator" : "collaborators")")
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
	AchievmentsWidgetView(number: 1, collaborators: 1)
}
