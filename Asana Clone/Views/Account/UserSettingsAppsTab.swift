//
//  UserSettingsAppsTab.swift
//  Asana Clone
//
//  Created by Nick on 7/5/23.
//

import SwiftUI

struct UserSettingsAppsTab: View {
    var body: some View {
		Form {
            SwiftUI.Section("Available Apps") {
				HStack {
					Image("harvestIcon")
						.resizable()
						.frame(width: 20, height: 20)
					
					Link("Harvest Time Tracking", destination: URL(string: "http://www.getharvest.com/asana-time-tracking")!)
					
					Spacer()
					
					Toggle("Activate", isOn: .constant(false))
						.labelsHidden()
				}
			}
			
            SwiftUI.Section {
				
			} header: {
				Text("Authorized Apps")
			} footer: {
				Text("Applications you authorize with Asana Connect will appear here.")
			}
		}
		.scrollContentBackground(.hidden)
    }
}

#Preview {
    UserSettingsAppsTab()
}
