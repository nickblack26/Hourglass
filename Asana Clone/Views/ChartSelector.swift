//
//  ChartSelector.swift
//  Asana Clone
//
//  Created by Nick on 7/10/23.
//

import SwiftUI

struct ChartSelector: View {
	let title: String
	let image: String
    var body: some View {
		VStack(alignment: .leading) {
			Text(title)
			Image(image)
				.resizable()
				.scaledToFit()
				.frame(height: 80)
		}
		.frame(maxHeight: .infinity)
		.padding()
		.background {
			RoundedRectangle(cornerRadius: 5)
				.fill(.clear)
				.stroke(.secondary)
		}
    }
}

#Preview {
	ChartSelector(title: "Stuff", image: "Stuff")
}
