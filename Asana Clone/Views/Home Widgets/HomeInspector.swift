//
//  HomeInspector.swift
//  Asana Clone
//
//  Created by Nick on 6/26/23.
//

import SwiftUI

//enum WidgetOption: String, CaseIterable {
//	case myTasks = "My Tasks"
//	case people = "People"
//	case projects  = "Projects"
//	case notepad = "Private notepad"
//	case tasksAssigned = "Tasks I've assigned"
//	case draftComments = "Draft comments"
//	case forms = "forms"
//	case myGoals = "My goals"
//
//	var image: String {
//		switch self {
//			case .myTasks: return "peopleWidgetExample"
//			case .people: return "peopleWidgetExample"
//			case .projects: return "peopleWidgetExample"
//			case .notepad: return "peopleWidgetExample"
//			case .tasksAssigned: return "peopleWidgetExample"
//			case .draftComments: return "peopleWidgetExample"
//			case .forms: return "peopleWidgetExample"
//			case .myGoals: return "peopleWidgetExample"
//		}
//	}
//}

struct Scheme {
	var background: Color
	var foreground: Color
	var image: String
}

enum ColorScheme: String, CaseIterable {
	case maroon
	case orange
	case yellow_green
	case green
	case blue_green
	case aqua
	case blue
	case purple
	case pink_purple
	case pink
	case oat
	case white
	
	var preferences: Scheme {
		switch self {
			case .maroon: return .init(background: .maroon, foreground: .white, image: "maroon")
			case .orange: return .init(background: .orangeYellow, foreground: .black, image: "orange_yellow")
			case .yellow_green: return .init(background: .yellowGreen, foreground: .black, image: "yellow_green")
			case .green: return .init(background: .forest, foreground: .white, image: "forest")
			case .blue_green: return .init(background: .blueGreen, foreground: .black, image: "blue_green")
			case .aqua: return .init(background: .aqua, foreground: .black, image: "aqua")
			case .blue: return .init(background: Color("BlueColor"), foreground: .white, image: "blue")
			case .purple: return .init(background: Color("PurpleColor"), foreground: .white, image: "purple")
			case .pink_purple: return .init(background: Color("PinkPurpleColor"), foreground: .white, image: "pink_purple")
			case .pink: return .init(background: Color("PinkColor"), foreground: .black, image: "pink")
			case .oat: return .init(background: .oat, foreground: .black, image: "oat")
			case .white: return .init(background: Color("Classic"), foreground: .black, image: "classic")
		}
	}
}


struct HomeInspector: View {
	@State private var vm = HomeViewModel.shared
	@Binding var colorScheme: ColorScheme
	
	init(colorScheme: Binding<ColorScheme>) {
		self._colorScheme = colorScheme
	}
	
	var body: some View {
		Form {
			Section("Background") {
				Grid {
					GridRow {
						ForEach(0..<6) { index in
							SwatchView(colorPreference: ColorScheme.allCases[index], selected: $colorScheme)
						}
					}
					GridRow {
						ForEach(6..<12) { index in
							SwatchView(colorPreference: ColorScheme.allCases[index], selected: $colorScheme)
						}
					}
				}
			}
			
			Section {
				ForEach(vm.availableWidgets, id: \.self) { option in
					ZStack(alignment: .topLeading) {
						Image(option.image)
							.resizable()
							.scaledToFit()
						Text(option.name)
							.padding()
					}
					.listRowBackground(EmptyView())
					.listRowSeparator(.hidden)
					.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.draggable(option) {
						RoundedRectangle(cornerRadius: 10)
							.fill(.ultraThinMaterial)
							.frame(width: 150, height: 150)
							.onAppear {
								vm.draggingItem = option
							}
					}
				}
			} header: {
				Text("Widgets")
			} footer: {
				Text("Drag to add the widgets below to your Home screen. You can also reorder and remove them.")
					.padding(.top, -15)
			}
		}
#if os(iOS)
		.navigationBarTitleDisplayMode(.inline)
#endif
		.navigationTitle("Customize Home")
		.inspectorColumnWidth(min: 300, ideal: 400, max: 500)
		//		.scrollContentBackground(.hidden)
	}
}

#Preview {
	VStack {
		
	}.inspector(isPresented: .constant(true)) {
		HomeInspector(colorScheme: .constant(.maroon))
	}
}
