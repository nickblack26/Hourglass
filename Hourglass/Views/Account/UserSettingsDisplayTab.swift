//
//  UserSettingsDisplayTab.swift
//  Asana Clone
//
//  Created by Nick on 7/5/23.
//

import SwiftUI

enum SystemTheme: String, CaseIterable {
	case system = "Sync with system settings"
	case light = "Light"
	case dark = "Dark"
}

struct UserSettingsDisplayTab: View {
	@State private var themeSelection: SystemTheme = .system
	@State private var weekStart: Day = .Sunday
	@State private var showTaskRowNums: Bool = false
	@State private var compactMode: Bool = false
	@State private var colorBlindMode: Bool = false
	@State private var celebrations: Bool = true
	
    var body: some View {
		Form {
            SwiftUI.Section("Theme") {
				Picker("Theme", selection: $themeSelection) {
					ForEach(SystemTheme.allCases, id: \.self) {theme in
						Text(theme.rawValue)
					}
				}
			}
			.labelsHidden()
			
            SwiftUI.Section("Language") {
				Picker("Language", selection: .constant("English")) {
					Text("English")
				}
				.labelsHidden()
			}
			
            SwiftUI.Section("First day of the week") {
				Picker("Language", selection: $weekStart) {
					Text(Day.Sunday.rawValue)
						.tag(Day.Sunday)
					
					Text(Day.Monday.rawValue)
						.tag(Day.Monday)
					
					Text(Day.Saturday.rawValue)
						.tag(Day.Saturday)
				}
				.labelsHidden()
			}
			
            SwiftUI.Section("Advanced Options") {
				Toggle("Show task row numbers", isOn: $showTaskRowNums)
				Toggle("Enable compact mode", isOn: $compactMode)
				Toggle("Enable color blind friendly mode (protanopia and deuteranopia)", isOn: $colorBlindMode)
				Toggle("Show occasional celebrations upon task completion", isOn: $celebrations)
			}
		}
		.scrollContentBackground(.hidden)
    }
}

#Preview {
    UserSettingsDisplayTab()
}
