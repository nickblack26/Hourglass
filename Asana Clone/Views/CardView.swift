//
//  CardView.swift
//  Asana Clone
//
//  Created by Nick on 6/26/23.
//

import SwiftUI

struct CardView: View {
	let title: String
	
    var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text(title)
					.font(.title3)
					.fontWeight(.bold)
		
			}
			
			Spacer()
		}
		.padding()
		.frame(height: 400)
		.background {
			RoundedRectangle(cornerRadius: 8.0)
				.fill(.cardBackground)
				.stroke(.cardBorder, lineWidth: 1)
		}
    }
}

#Preview {
    CardView(title: "Projects")
}
