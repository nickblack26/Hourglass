//
//  TableCellView.swift
//  Asana Clone
//
//  Created by Nick on 7/17/23.
//

import SwiftUI

struct TableDateCellView: View {
	@Environment(\.calendar) var calendar
	@Environment(\.timeZone) var timeZone
	@State private var showPicker: Bool = false
	@State private var dates: Set<DateComponents> = []
	var title: String
	var start_date: Date?
	var end_date: Date?
	
	init(title: String, start_date: Date? = nil, end_date: Date? = nil) {
		self.title = title
		self.start_date = start_date
		self.end_date = end_date
		if let start_date {
			dates.insert(Calendar.current.dateComponents(in: TimeZone.current, from: start_date))
		}
		if let end_date {
			dates.insert(Calendar.current.dateComponents(in: TimeZone.current, from: end_date))
		}
	}
	
	var body: some View {
		Button {
			showPicker.toggle()
		} label: {
			if dates.isEmpty {
				Image(systemName: "calendar.circle")
			} else {
				HStack {
					let dateArray = Array(dates)
					ForEach(dateArray, id: \.self) { date in
						let actualDate = date.date
						Text(actualDate?.formatted(date: .abbreviated, time: .omitted) ?? "")
					}
				}
			}
		}
		.popover(isPresented: $showPicker, content: {
			if let start_date {
				MultiDatePicker(title, selection: $dates, in: start_date...)
			} else {
				MultiDatePicker(title, selection: $dates)
			}
		})
	}
}

#Preview {
	TableDateCellView(title: "Due date")
}
