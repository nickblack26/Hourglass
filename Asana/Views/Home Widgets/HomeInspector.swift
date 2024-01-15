//
//  HomeInspector.swift
//  Asana Clone
//
//  Created by Nick on 6/26/23.
//

import SwiftUI
import SwiftData

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
            case .white: return .init(background: .white, foreground: .black, image: "classic")
		}
	}
}

struct HomeInspector: View {
    @Environment(AsanaManager.self) private var asanaManager
    var availableWidgets: [Widget] {
        allWidgets.filter {
            return !allWidgets.contains($0)
        }
    }
    
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
                
				ForEach(availableWidgets, id: \.self) { widget in
					ZStack(alignment: .topLeading) {
						Image(widget.image)
							.resizable()
							.scaledToFit()
						Text(widget.name)
							.padding()
					}
					.listRowBackground(EmptyView())
					.listRowSeparator(.hidden)
					.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
					.clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        
//                        if let currentMember = asanaManager.currentMember {
//                            withAnimation(.snappy) {
//                                currentMember.widgets?.append(widget)
//                            }
//                        }
                    }
//					.draggable(option) {
//						RoundedRectangle(cornerRadius: 10)
//							.fill(.ultraThinMaterial)
//							.frame(width: 150, height: 150)
//							.onAppear {
////								vm.draggingItem = option
//							}
//					}
				}
			} header: {
				Text("Widgets")
			} footer: {
				Text("Drag to add the widgets below to your Home screen. You can also reorder and remove them.")
					.padding(.top, -15)
			}
		}
		.navigationTitle("Customize Home")
		.inspectorColumnWidth(min: 300, ideal: 400, max: 500)
		//		.scrollContentBackground(.hidden)
	}
}

#Preview {
    @State var asanaManager = AsanaManager()
    
	return VStack {
		
	}
    .environment(asanaManager)
    .inspector(isPresented: .constant(true)) {
		HomeInspector(colorScheme: .constant(.maroon))
            .environment(asanaManager)
	}
}
