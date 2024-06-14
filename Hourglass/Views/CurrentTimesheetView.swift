import SwiftUI

struct CurrentTimesheetView: View {
    @State private var timeFormatter = ElapsedTimeFormatter()
    var timesheet: TimeTrackingEntry
    
    var body: some View {
		
		TimelineView(
            TimesheetTimelineSchedule(from: timesheet.createdAt!)
		) { context in
			VStack(alignment: .leading, spacing: 12) {
				HStack {
                    Text(timesheet.task?.name ?? "")
						.font(.subheadline)
					
					Spacer()
					
                    FormattedCurrencyField(25)
						.foregroundStyle(.secondary)
						.font(.caption)
				}
				.padding(.horizontal, 4)
				
				HStack(spacing: 16) {
					Button {
						withAnimation(.snappy) {
//							timesheet.end = .now
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
                        NSNumber(value: Date.now.timeIntervalSince(timesheet.enteredOn!)),
						formatter: timeFormatter
					)
					
					Spacer()
					
					Button("Stop") {
						withAnimation(.snappy) {
//							timesheet.end = .now
						}
					}
					.buttonStyle(.plain)
					.foregroundStyle(.secondary)
					.font(.subheadline)
				}
				.padding(.vertical, 8)
				.padding(.horizontal, 8)
                #if os(iOS)
                .background(
                    Color(uiColor: .systemGray6),
                    in: .rect(cornerRadius: 8)
                )
                #endif
                #if os(macOS)
                .background(
                    Color(nsColor: .systemGray),
                    in: .rect(cornerRadius: 8)
                )
                #endif
				.fontWeight(.light)
				.listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
			}
			.padding(8)
			.background {
				RoundedRectangle(cornerRadius: 12)
					.fill(.background)
                    #if os(iOS)
                    .strokeBorder(
                        Color(uiColor: .systemGray5),
                        style: .init(lineWidth: 1)
                    )
                    #endif
                    #if os(macOS)
                    .strokeBorder(
                        Color(nsColor: .systemGray),
                        style: .init(lineWidth: 1)
                    )
                    #endif
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
            #if os(iOS)
            .fill(Color(uiColor: .systemGray6))
            #endif
            #if os(macOS)
            .fill(Color(nsColor: .systemGray))
            #endif
				
		)
    }
}

#Preview("Timesheet View") {
    @Previewable @Bindable var timesheet: TimeTrackingEntry = .init(createdBy: nil, durationMinutes: nil, enteredOn: nil, task: nil)
    
    NavigationSplitView {
		List {
			CurrentTimesheetView(
                timesheet: timesheet
			)
            #if os(iOS)
            .listRowBackground(Color(uiColor: .systemGray6))
            #endif
            #if os(macOS)
            .listRowBackground(Color(nsColor: .systemGray))
            #endif
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
