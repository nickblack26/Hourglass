//
//  AsanaCloneAppViewModel.swift
//  Asana Clone
//
//  Created by Nick on 6/22/23.
//

import Foundation
import Observation

@Observable
class UserDefaultsViewModel {
	var id: String? = UUID().uuidString
	var scheme: ColorScheme = .white
	var totalRows: Int = 0
	var homeWidgets: [WidgetOptionModel] = defaultWidgets
	private let defaults = UserDefaults.standard
	
	init() {
		getUserDefaults()
	}
	
	private func getUserDefaults() {
		if let user_id = defaults.object(forKey: "accessToken") {
			self.id = user_id as? String
			
		} else {
			self.id = nil
		}
		
		if let scheme = defaults.object(forKey: "color_scheme") {
			self.scheme = ColorScheme(rawValue: scheme as? String ?? "white") ?? .white
		}
		
//		guard let widgets = defaults.data(forKey: "home_widgets") else { return }
//		guard let savedItems = try? JSONDecoder().decode([WidgetOptionModel].self, from: widgets) else { return }
		
		let totalSpaces = homeWidgets.reduce(0.0) { partialResult, widget in
			partialResult + Double(widget.columns)
		}
		
		self.totalRows = Int((totalSpaces / 2).rounded(.up))

//		self.homeWidgets = savedItems
	}
}
