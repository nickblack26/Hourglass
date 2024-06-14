//
//  SwatchView.swift
//  Asana Clone
//
//  Created by Nick on 6/26/23.
//

import SwiftUI



struct SwatchView: View {
	let colorPreference: ColorScheme
	@Binding var selected: ColorScheme
	
    var body: some View {
		Button {
			selected = colorPreference
//			defaults.setValue(selected.rawValue, forKey: "color_scheme")
		} label: {
			ZStack {
				Circle()
					.stroke(colorPreference == .white ? .gray : .clear, lineWidth: 1)
					.fill(colorPreference.preferences.background)
					.frame(width: 50, height: 50)
					
				
				if (selected == colorPreference) {
					Image(systemName: "checkmark")
						.foregroundStyle(selected.preferences.foreground)
				}
			}
		}
		.buttonStyle(.plain)
    }
}

#Preview {
	SwatchView(colorPreference: .purple, selected: .constant(.purple))
}
