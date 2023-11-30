//
//  UserSettingsGeneralTabViewModel.swift
//  Asana Clone
//
//  Created by Nick on 7/5/23.
//

import SwiftUI

struct UserSettingsGeneralTab: View {
	@State private var globalShortcutsEnabled: Bool = true
	@State private var appIcon: Bool = true
	@State private var pomodoroUi: Bool = true
	@State private var pauseNotifications: Bool = true
	@State private var playSound: Bool = true
	
    var body: some View {
		Form {
			Section {
				Toggle(isOn: $globalShortcutsEnabled) {
					VStack(alignment: .leading) {
						Text("Enable global keyboard shortcuts")
						Text("Create a task from anywhere with ⌘ ⇧ +")
							.foregroundStyle(.secondary)
					}
				}
			} header: {
				Text("Global keyboard shortcuts")
					.font(.title2)
					.fontWeight(.bold)
			}
			.headerProminence(.increased)
			
			Section {
				Toggle(isOn: $appIcon) {
					VStack(alignment: .leading) {
						Text("Enable Asana app icon")
						Text("Show the Asana icon in the menu bar (you must restart Asana for changes to take effect)")
							.foregroundStyle(.secondary)
					}
				}
			} header: {
				Text("Tray App Settings")
					.font(.title2)
					.fontWeight(.bold)
			}
			.headerProminence(.increased)
			
			Section {
				Toggle(isOn: $pomodoroUi) {
					VStack(alignment: .leading) {
						Text("Enable persistent pomodoro UI")
						Text("Keep a floating desktop reminder of your pomodoro session")
							.foregroundStyle(.secondary)
					}
				}
				
				Toggle(isOn: $pauseNotifications) {
					VStack(alignment: .leading) {
						Text("Pause notifications")
						Text("Pomodoro sessions pause Asana notifications by default")
							.foregroundStyle(.secondary)
					}
				}
				
				Toggle(isOn: $playSound) {
					VStack(alignment: .leading) {
						Text("Play sound")
						Text("Play a sound upon timer completion")
							.foregroundStyle(.secondary)
					}
				}
				
			} header: {
				Text("Pomodoro Timer")
					.font(.title3)
					.fontWeight(.bold)
			}
			.headerProminence(.increased)
			.listRowSeparator(.hidden)

		}
		.scrollContentBackground(.hidden)
    }
}

#Preview {
    UserSettingsGeneralTab()
}
