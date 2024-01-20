import SwiftUI

struct CurrentTimesheetView: View {
    @State private var timeFormatter = ElapsedTimeFormatter()
	var timesheet: Timesheet
    
    var body: some View {
		
		TimelineView(
			TimesheetTimelineSchedule(from: timesheet.start)
		) { context in
			VStack(alignment: .leading, spacing: 12) {
				HStack {
					Text(timesheet.project?.name ?? "")
						.font(.subheadline)
					
					Spacer()
					
					Text(25, format: .currency(code: "usd"))
						.foregroundStyle(.secondary)
						.font(.caption)
				}
				.padding(.horizontal, 4)
				
				HStack(spacing: 16) {
					Button {
						withAnimation(.snappy) {
							timesheet.end = .now
						}
					} label: {
						RoundedRectangle(cornerRadius: 2)
							.frame(width: 8, height: 8)
							.foregroundStyle(.red)
							.padding(6)
							.background(.background, in: .circle)
					}
					.buttonStyle(.plain)
					
					Text(
						NSNumber(value: Date.now.timeIntervalSince(timesheet.start)),
						formatter: timeFormatter
					)
					
					Spacer()
					
					Button("Stop") {
						withAnimation(.snappy) {
							timesheet.end = .now
						}
					}
					.buttonStyle(.plain)
					.foregroundStyle(.secondary)
					.font(.subheadline)
				}
				.padding(.vertical, 8)
				.padding(.horizontal, 8)
				.background(
					Color(uiColor: .systemGray6),
					in: .rect(cornerRadius: 8)
				)
				.fontWeight(.light)
				.listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
			}
			.padding(8)
			.background {
				RoundedRectangle(cornerRadius: 12)
					.fill(.background)
					.strokeBorder(
						Color(uiColor: .systemGray5),
						style: .init(lineWidth: 1)
					)
			}
		}
		.listRowInsets(
			EdgeInsets(
				top: 4,
				leading: 4,
				bottom: 4,
				trailing: 4
			)
		)
		.listRowBackground(
			RoundedRectangle(cornerRadius: 16)
				.fill(Color(uiColor: .systemGray6))
		)
    }
}

#Preview {
	NavigationSplitView {
		List {
			CurrentTimesheetView(
				timesheet: .init()
			)
			.listRowBackground(Color(uiColor: .systemGray6))
			.listRowInsets(.none)
		}
		.scrollContentBackground(.hidden)
		.listStyle(.sidebar)
	} detail: {
		
	}
}


private struct TimesheetTimelineSchedule: TimelineSchedule {
	var startDate: Date
	
	init(from startDate: Date) {
		self.startDate = startDate
	}
	
	func entries(from startDate: Date, mode: TimelineScheduleMode) -> PeriodicTimelineSchedule.Entries {
		PeriodicTimelineSchedule(
			from: self.startDate,
			by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0)
		).entries(
			from: startDate,
			mode: mode
		)
	}
}
