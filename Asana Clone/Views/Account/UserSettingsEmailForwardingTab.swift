//
//  UserSettingsEmailForwardingTab.swift
//  Asana Clone
//
//  Created by Nick on 7/5/23.
//

import SwiftUI

struct UserSettingsEmailForwardingTab: View {
	var body: some View {
		Form {
			Text("You can create tasks & messages from email addresses associated with Asana.")
				.listRowSeparator(.hidden)

			Text("Create tasks by emailing x@mail.asana.com. Tasks emailed will appear in your My tasks list.")
				.listRowSeparator(.hidden)

			Text("• The subject line will be the task name")
				.listRowSeparator(.hidden)

			Text("• The body will be the task description")
				.listRowSeparator(.hidden)

			Text("• All email attachments will be attached to the task")
				.listRowSeparator(.hidden)

			Text("• You can cc teammates to add them as task collaborators")
				.listRowSeparator(.hidden)

			Text("Create messages by emailing [team-name]@mail.asana.com. For example, marketing@mail.asana.com goes to the Marketing team, and customer-success@mail.asana.com goes to the Customer Success team")
				.listRowSeparator(.hidden)

			HStack {
				VStack(alignment: .leading) {
					Section("Emails Sent From") {
						Text("nicholas.black98@icloud.com")
					}
				}
				
				Spacer()
				
				VStack(alignment: .leading) {
					Section("Create Tasks & Messages in") {
						Picker("", selection: .constant("Engineering")) {
							Text("Engineering")
						}
					}
				}
				
				Spacer()
			}
			.listRowSeparator(.hidden)

		}
		.scrollContentBackground(.hidden)
	}
}

#Preview {
	UserSettingsEmailForwardingTab()
}
