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
    @State private var showTime: Bool = false
    @State private var dates: Set<DateComponents> = [] {
        didSet {
            let dateArray = Array(dates)
            print(dateArray)
            if dateArray.count > 1 {
                start_date = dateArray.first?.date
                end_date = dateArray.last?.date
                
                print(start_date, end_date)
            } else {
                end_date = dateArray.first?.date
                print(end_date)
            }
        }
    }
	var title: String
	@Binding var start_date: Date?
    @Binding var end_date: Date?
    
	init(title: String, start_date: Binding<Date?>, end_date: Binding<Date?>) {
		self.title = title
		self._start_date = start_date
		self._end_date = end_date
        if let start_date = start_date.wrappedValue {
			dates.insert(Calendar.current.dateComponents(in: TimeZone.current, from: start_date))
		}
		if let end_date = end_date.wrappedValue {
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
            VStack {
                HStack {
                    TextField(
                        "Start date",
                        text: Binding(get: {
                            return start_date?.formatted(date: .abbreviated, time: .omitted) ?? Date.now.formatted(date: .abbreviated, time: .omitted)
                        }, set: { newValue in
                            start_date = try? Date(from: newValue as! Decoder)
                        }),
                        prompt: Text("Start date")
                    )
                    .textFieldStyle(.roundedBorder)
                    .labelsHidden()
                        
                    TextField(
                        "End date",
                        text: Binding(get: {
                            return end_date?.formatted(date: .abbreviated, time: .omitted) ?? Date.now.formatted(date: .abbreviated, time: .omitted)
                        }, set: { newValue in
                            start_date = try? Date(from: newValue as! Decoder)
                        }),
                        prompt: Text("End date")
                    )
                    .textFieldStyle(.roundedBorder)
                    .labelsHidden()
                }
                .padding([.top, .horizontal])
                
                if showTime {
                    HStack {
                        DatePicker(
                            "Start time",
                            selection:
                                Binding(
                                    get: { return start_date ?? Date() },
                                    set: { newValue in
                                        start_date = newValue
                                    }
                                ),
                            displayedComponents: [.hourAndMinute]
                        )
                        .labelsHidden()
                        .datePickerStyle(.compact)
                            
                        DatePicker(
                            "Start time",
                            selection:
                                Binding(
                                    get: { return end_date ?? Date() },
                                    set: { newValue in
                                        end_date = newValue
                                    }
                                ),
                            displayedComponents: [.hourAndMinute]
                        )
                        .labelsHidden()
                        .datePickerStyle(.compact)
                    }
                    .padding([.horizontal])
                }
                
                MultiDatePicker(title, selection: $dates)
                
                Divider()
                
                HStack {
                    if showTime {
                        Button("Show time", systemImage: "clock") {
                           withAnimation {
                                showTime.toggle()
                            }
                        }
                        .labelsHidden()
                        .tint(.accent)
                        .buttonStyle(.bordered)
                    } else {
                        Button("Show time", systemImage: "clock") {
                           withAnimation {
                                showTime.toggle()
                            }
                        }
                        .labelsHidden()
                        .buttonStyle(.plain)
                    }
                    
                    if showTime {
                        Button("Set to repeat", systemImage: "arrow.rectanglepath") {
                           
                        }
                        .labelsHidden()
                        .tint(.accent)
                        .buttonStyle(.bordered)
                    } else {
                        Button("Set to repeat", systemImage: "repeat") {
                           
                        }
                        .labelsHidden()
                        .buttonStyle(.plain)
                    }
                    
                    Spacer()
                    
                    Button("Clear") {
                        start_date = nil
                        end_date = nil
                    }
                    .buttonStyle(.plain)
                }
                .padding()
            }
		})
	}
}

#Preview {
    TableDateCellView(title: "Due date", start_date: .constant(nil), end_date: .constant(nil))
}
