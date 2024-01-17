//
//  UserSettingsHacksTab.swift
//  Asana Clone
//
//  Created by Nick on 7/5/23.
//

import SwiftUI

struct UserSettingsHacksTab: View {
	@State private var extraDelight: Bool = true
	@State private var recurringTask: Bool = true
	@State private var disableNotifications: Bool = true
	
	var body: some View {
		Form {
            SwiftUI.Section {
				Toggle(isOn: $extraDelight) {
					VStack(alignment: .leading) {
						Text("Extra delight")
						HStack {
							Text("Adds additional celebrations and delightful surprises to the product experience.")
								.foregroundStyle(.secondary)
							
							Link("Share feedback", destination: URL(string: "https://forum.asana.com/t/unicorn-and-asana-creatures-celebration-hack-motivation-for-tasks/3715")!)
						}
						.font(.caption)
					}
				}
				
				Toggle(isOn: $extraDelight) {
					VStack(alignment: .leading) {
						Text("Recurring tasks in the last section of My tasks")
						Text("Makes recurring tasks always reappear in the last section of My tasks when you complete them instead of the default column.")
							.font(.caption)
							.foregroundStyle(.secondary)
						
					}
				}
				
				Toggle(isOn: $extraDelight) {
					VStack(alignment: .leading) {
						Text("Disable notifications for tasks starting & due today")
						
						HStack {
							Text("Stop receiving notifications in your inbox for tasks starting or due today.")
								.foregroundStyle(.secondary)
							
							Link("Share feedback", destination: URL(string: "https://forum.asana.com/c/productfeedback/20")!)
						}
						.font(.caption)
					}
				}
			} header: {
				Text("Hacks are experimental features that we’ve been tinkering with. They are not supported features and may change, break, or disappear at any time.")
			}
		}
		.scrollContentBackground(.hidden)
	}
}

#Preview {
	UserSettingsHacksTab()
}
