//
//  ProfileGeneralTab.swift
//  Asana Clone
//
//  Created by Nick on 7/5/23.
//

import SwiftUI

struct UserSettingsProfileTab: View {
	@State private var name: String = ""
	@State private var ooo: Bool = false
    var member: MemberModel

    var body: some View {
		Form {
			Section("Your photo") {
				HStack {
					Image("profile")
						.resizable()
						.scaledToFill()
						.frame(width: 50, height: 50)
						.clipShape(Circle())
					
					VStack(alignment: .leading) {
						HStack {
							Button {
								
							} label: {
								Text("Upload new photo")
							}
							
							Text("•")
								.foregroundStyle(.secondary)
							
							Button {
								
							} label: {
								Text("Remove photo")
							}
						}
						
						Text("Photos help your teammates recognize you in Asana")
							.font(.caption)
							.foregroundStyle(.secondary)
					}
				}
			}
			
			Section {
				HStack {
//					TextField("Your full name", text: $vm.fullName)
//					TextField("Pronouns", text: $vm.pronouns)
				}
				HStack {
//					TextField("Job title", text: $vm.jobTitle)
//					TextField("Department or team", text: $vm.area)
				}
//				TextField("Email", text: $vm.email)
								
//				TextField("I usually work from 9am-5pm PST. Feel free to assign me a task with a due date anytime. Also, I love dogs!", text: $vm.about, axis: .vertical)
//					.lineLimit(3, reservesSpace: true)
				
				
			}
			
			Section {
//				Toggle("Set out of office", isOn: $vm.outOfOffice)
//				Toggle("Allow others in your organization to see when you're active in Asana", isOn: $vm.allowOutsideObservation)
			}
			
			Section("Invite type") {
				Text("Signed up on \(Date(), format: Date.FormatStyle(date: .abbreviated, time: .omitted))")
			}
		}
		.scrollContentBackground(.hidden)
    }
}

#Preview {
    UserSettingsProfileTab(member: .preview)
}
