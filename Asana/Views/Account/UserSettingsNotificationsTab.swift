//
//  UserSettingsNotificationsTab.swift
//  Asana Clone
//
//  Created by Nick on 7/5/23.
//

import SwiftUI

enum Day: String, CaseIterable {
	case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}

struct UserSettingsNotificationsTab: View {
	@State private var startTime: Date = Date()
	@State private var endTime: Date = Date()
	@State private var selectedDays = Set<Day>()
	@State private var activityUpdates: Bool = true
	@State private var mentionsOnly: Bool = true
	@State private var dailySummaries: Bool = true
	@State private var weeklyReports: Bool = true
	
	init() {
		self._startTime = State(initialValue: startDate())
		self._endTime = State(initialValue: endDate())
	}
	
	func startDate() -> Date {
		var components = DateComponents()
		components.hour = 8
		components.minute = 0
		return Calendar.current.date(from: components) ?? Date()
	}
	
	func endDate() -> Date {
		var components = DateComponents()
		components.hour = 17
		components.minute = 0
		return Calendar.current.date(from: components) ?? Date()
	}
	
	var body: some View {
		Form {
            SwiftUI.Section {
				Button {
					
				} label: {
					Label("Pause notifications", systemImage: "bell.slash")
						.padding(.horizontal)
						.padding(.vertical, 10)
						.foregroundStyle(.secondary)
						.background {
							RoundedRectangle(cornerRadius: 5)
								.fill(.clear)
								.stroke(.gray)
						}
				}
				.buttonStyle(.plain)
			} header: {
				Text("Do no disturb")
					.font(.title2)
					.fontWeight(.medium)
			}
			.headerProminence(.increased)
			
            SwiftUI.Section("Schedule") {
				Toggle(isOn: .constant(true), label: {
					HStack {
						Text("Do not notify me from:")
						
						DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
							.labelsHidden()
						
						Text("To:")
						
						DatePicker("End Time", selection: $endTime,  displayedComponents: .hourAndMinute)
							.labelsHidden()
					}
				})
			}
			.headerProminence(.increased)
			
            SwiftUI.Section("Do not disturb me on my days off") {
				HStack {
					List(Day.allCases, id: \.self, selection: $selectedDays) { day in
						Text(String(day.rawValue.prefix(3)))
							.padding(.horizontal, 5)
							.padding(.vertical, 5)
						
						if(day != .Saturday) {
							Divider()
						}
					}
				}
				.padding(.horizontal, 10)
				.background {
					RoundedRectangle(cornerRadius: 5)
						.fill(.clear)
						.stroke(.gray)
				}
			}
			
            SwiftUI.Section("Email notifications") {
				Picker("Preferred email", selection: .constant("nicholas.black98@icloud.com")) {
					Text("nicholas.black98@icloud.com")
				}
				.labelsHidden()
				
				Text("Send me email notifications for:")
				
				Toggle(isOn: $activityUpdates) {
					VStack(alignment: .leading, content: {
						Text("Activity updates")
						Text("New tasks assigned to you, @mentions, and completion notifications for tasks you're a collaborator on")
					})
				}
				
				Toggle(isOn: $mentionsOnly) {
					VStack(alignment: .leading, content: {
						Text("Mentions only")
						Text("New tasks assigned to you, direct messages, and @mentions")
					})
				}
				
				Toggle(isOn: $dailySummaries) {
					VStack(alignment: .leading, content: {
						Text("Daily summaries")
						Text("New tasks assigned to you and upcoming due dates")
					})
				}
				
				Toggle(isOn: $weeklyReports) {
					VStack(alignment: .leading, content: {
						Text("Weekly reports")
						Text("Status updates on projects in your portfolios")
					})
					.foregroundStyle(.secondary)
				}
				.disabled(true)
				.listRowSeparator(.visible)
				
				HStack {
					Button {
						
					} label: {
						Label("Add New Email", systemImage: "plus")
					}
					
					Spacer()
					
					Button {
						
					} label: {
						Text("Remove Email")
					}
				}
			}
			.headerProminence(.increased)
			.listRowSeparator(.hidden)
			
			Divider()
		}
		.scrollContentBackground(.hidden)
	}
}

#Preview {
	UserSettingsNotificationsTab()
}
