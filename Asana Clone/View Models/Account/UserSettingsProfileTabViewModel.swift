	//
	//  EditProfileModelViewModel.swift
//  Asana Clone
//
//  Created by Nick on 7/5/23.
//

import Foundation
import Observation

@Observable
class UserSettingsProfileTabViewModel {
	var fullName: String = ""
	var profile_url: String = ""
	var email: String = ""
	var pronouns: String = ""
	var jobTitle: String = ""
	var area: String = ""
	var about: String = ""
	var outOfOffice: Bool = false
	var allowOutsideObservation: Bool = true
	private let manager = SupabaseManger.shared
	
	init() {
		getUserMetadata()
	}
	
	private func getUserMetadata() {
		Task {
			let response = await manager.getUser()
			self.fullName = response?.name ?? ""
			self.about = response?.about ?? ""
			self.profile_url = response?.profile_image_url ?? ""
		}
	}
}
