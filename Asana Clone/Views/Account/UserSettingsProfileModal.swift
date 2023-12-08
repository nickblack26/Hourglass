//
//  EditProfileModalView.swift
//  Asana Clone
//
//  Created by Nick on 7/5/23.
//

import SwiftUI

enum UserSettingsTab: String, CaseIterable {
	case general = "General"
	case profile = "Profile"
	case notifications = "Notifications"
	case emailForwarding = "Email Forwarding"
	case account = "Account"
	case display = "Display"
	case apps = "Apps"
	case hacks = "Hacks"
}

struct UserSettingsProfileModal: View {
	@State private var tabSelection: UserSettingsTab = .general
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				ForEach(UserSettingsTab.allCases, id: \.self) { tab in
					Button {
						tabSelection = tab
					} label: {
						Text(tab.rawValue)
							.foregroundStyle(tabSelection == tab ? .primary : .secondary )
							.padding(.trailing, 5)
					}
					.buttonStyle(.plain)
				}
			}
			.padding(.horizontal, 20)
			.padding(.top)
			
			Divider()
			
			TabView(selection: $tabSelection) {
				UserSettingsGeneralTab()
					.tag(UserSettingsTab.general)
				
                UserSettingsProfileTab(member: .preview)
					.tag(UserSettingsTab.profile)
				
				UserSettingsNotificationsTab()
					.tag(UserSettingsTab.notifications)
				
				UserSettingsEmailForwardingTab()
					.tag(UserSettingsTab.emailForwarding)
				
				UserSettingsAccountTab()
					.tag(UserSettingsTab.account)
				
				UserSettingsDisplayTab()
					.tag(UserSettingsTab.display)
				
				UserSettingsAppsTab()
					.tag(UserSettingsTab.apps)
				
				UserSettingsHacksTab()
					.tag(UserSettingsTab.hacks)
			}
		}
		.toolbar {
			ToolbarItem(placement: .topBarLeading) {
				Text("My Settings")
					.font(.largeTitle)
					.fontWeight(.bold)
			}
		}
		.tabViewStyle(.page(indexDisplayMode: .never))
	}
}

#Preview {
	Text("Hello")
		.sheet(isPresented: .constant(true)) {
			NavigationStack {
				UserSettingsProfileModal()
			}
		}
}
