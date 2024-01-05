//
//  ProjectTile.swift
//  Asana Clone
//
//  Created by Nick on 6/30/23.
//

import SwiftUI

struct ProjectTile: View {
	@State private var isHovering: Bool = false
	let image: String?
	let icon: String?
	let title: String
	let subtitle: String
	
	var body: some View {
		VStack {
			if(icon == nil) {
				Image(image ?? "")
					.font(.largeTitle)
					.frame(width: 125, height: 125)
					.background {
						RoundedRectangle(cornerRadius: 15)
							.stroke(lineWidth: 1)
					}
					.foregroundStyle(.secondary.opacity(0.25))
			} else {
				Image(systemName: icon ?? "plus")
					.font(.largeTitle)
					.frame(width: 125, height: 125)
					.background {
						RoundedRectangle(cornerRadius: 15)
							.strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
					}
					.foregroundStyle(.secondary)
			}
			
			
			Text(title)
				.font(.subheadline)
				.fontWeight(.medium)
			
			Text(subtitle)
				.font(.caption)
				.foregroundStyle(.secondary)
		}
		.padding()
		.padding(.bottom, isHovering ? 25 : 0)
		.animation(.easeInOut, value: isHovering)
		.background(isHovering ? .gray.opacity(0.05) : .clear)
		.clipShape(RoundedRectangle(cornerRadius: 30))
		.onHover(perform: { hovering in
			self.isHovering = hovering
#if TARGET_OS_MACCATALYST
			DispatchQueue.main.async {
				if (self.isHovering) {
					NSCursor.pointingHand.push()
				} else {
					NSCursor.pop()
				}
			}
#endif
		})
	}
}

#Preview {
	ProjectTile(image: "rocket", icon: "plus", title: "Use a template", subtitle: "Choose from library")
}
