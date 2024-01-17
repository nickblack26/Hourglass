//
//  NewGenericGoal.swift
//  Asana Clone
//
//  Created by Nick on 7/10/23.
//

import SwiftUI

struct NewGenericGoal: View {
	@State private var name: String = ""
	@State private var owner: String = ""
	@State private var timePeriod = Set<DateComponents>()
	
    var body: some View {
		List {
			TextField("Enter goal name", text: $name)
			Picker("Goal owner", selection: $owner) {
				Text("Nick Black")
					.tag("Nick")
			}
			Picker("Company or accountable team", selection: $owner) {
				Text("Nick Black")
					.tag("Nick")
			}
			MultiDatePicker("Time period", selection: $timePeriod)
		}
    }
}

#Preview {
    NewGenericGoal()
}
