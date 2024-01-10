//
//  UserSettingsAccountTab.swift
//  Asana Clone
//
//  Created by Nick on 7/5/23.
//

import SwiftUI

struct UserSettingsAccountTab: View {
	let organizations: [String] = []
	let workspaces: [String] = ["Engineering"]
	@State private var changePassword: Bool = false
	@State private var currentPassword: String = ""
	@State private var newPassword: String = ""
	@State private var confirmNewPassword: String = ""
	
	func isNewPasswordValid() -> Bool {
		if(currentPassword.isEmpty || newPassword.isEmpty || confirmNewPassword.isEmpty) {
			return false
		}
		
		return (newPassword == confirmNewPassword) && (newPassword != currentPassword)
	}
	
	var body: some View {
		Form {
            SwiftUI.Section("Organizations and workspaces") {
				VStack(alignment: .leading) {
					HStack(alignment: organizations.count > 1 ? .top : .center) {
						Text("Organizations")
							.frame(width: 150, alignment: .trailing)
						Divider()
						VStack(alignment: .leading) {
							ForEach(organizations, id: \.self) { organization in
								Text(organization)
							}
						}
					}
					
					HStack(alignment: .top) {
						Text("Workspaces")
							.frame(width: 150, alignment: .trailing)
						Divider()
						VStack(alignment: .leading) {
							ForEach(workspaces, id: \.self) { workspace in
								Text(workspace)
							}
							Button {
								
							} label: {
								Text("Create new workspace")
							}
						}
					}
				}
			}
			.headerProminence(.increased)
			
            SwiftUI.Section("Password") {
				if(changePassword) {
//					SecureField("Current Password", text: $currentPassword)
//					VStack(alignment: .leading) {
//						SecureField("New Password", text: $newPassword)
//						Text("Create a password with at least 8 characters.")
//							.font(.caption)
//					}
//					
//					SecureField("Confirm New Password", text: $confirmNewPassword)
					TextField("Current Password", text: $currentPassword)
					VStack(alignment: .leading) {
						TextField("New Password", text: $newPassword)
						Text("Create a password with at least 8 characters.")
							.font(.caption)
					}
					
					TextField("Confirm New Password", text: $confirmNewPassword)
					
					
					VStack(alignment: .trailing) {
						HStack {
							Button {
								changePassword.toggle()
							} label: {
								Text("Cancel")
							}
							
							Button {
								
							} label: {
								Text("Save")
							}
							.disabled(!isNewPasswordValid())
						}
					}
				} else {
					HStack {
						Text("Change the password for your account")
						Spacer()
						Button {
							changePassword.toggle()
						} label: {
							Text("Change password")
						}
					}
				}
			}
			.headerProminence(.increased)
			
            SwiftUI.Section("Two-Factor Authentication") {
				HStack {
					Text("Require an authentication code when you log in with an email and password")
					Spacer()
					Button {
						
					} label: {
						Text("Enable")
					}
				}
			}
			.headerProminence(.increased)
			
            SwiftUI.Section("Two-Factor Authentication") {
				HStack {
					Text("Log out of all sessions except this current browser")
					Spacer()
					Button {
						
					} label: {
						Text("Log out other sessions")
					}
				}
			}
			.headerProminence(.increased)
			
            SwiftUI.Section("Deactivation") {
				HStack {
					Text("Remove access to all organizations and workspaces in Asana")
					Spacer()
					Button {
						
					} label: {
						Text("Deactivate account")
					}
				}
			}
			.headerProminence(.increased)
		}
		.scrollContentBackground(.hidden)
	}
}

#Preview {
	UserSettingsAccountTab()
}
