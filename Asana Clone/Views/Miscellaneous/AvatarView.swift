//
//  SwiftUIView.swift
//  Asana Clone
//
//  Created by Nick on 7/11/23.
//

import SwiftUI

enum AvatarSize {
	case tiny
	case small
	case medium
	case large
	
	var sizing: CGFloat {
		switch self {
			case .tiny: return 15
			case .small: return 25
			case .medium: return 50
			case .large: return 75
		}
	}
	
	var text: Font {
		switch self {
			case .tiny: return .caption
			case .small: return .callout
			case .medium: return .body
			case .large: return .headline
		}
	}
}

enum AvatarStyle {
	case image
	case imageWithText
}

struct AvatarView: View {
	let image: String?
	let fallback: String?
	let size: AvatarSize
	
	init(size: AvatarSize) {
		self.image = nil
		self.fallback = nil
		self.size = size
	}
	
	init(image: String?, fallback: String, size: AvatarSize) {
		self.image = image
		self.fallback = fallback
		self.size = size
	}
	
	var body: some View {
		AsyncImage(url: URL(string: "https://idesgwavccmmhoztqnfw.supabase.co/profiles_images/\(String(describing: image))")) { Image in
			Image
				.resizable()
				.frame(width: size.sizing, height: size.sizing)
				.scaledToFill()
				.clipShape(Circle())
		} placeholder: {
			if let fallback = fallback {
				let components = fallback.components(separatedBy: " ")
				
				HStack(spacing: 0) {
					if components.isIndexValid(index: 0) {
						Text(components[0].prefix(1))
							.font(size.text)
						
					}
					
					if components.isIndexValid(index: 1) {
						Text(components[1].prefix(1))
							.font(size.text)
					}
				}
				.textCase(.uppercase)
				.padding(.all, 10)
				.background(.blue)
				.clipShape(Circle())
			}
		}
	}
}

#Preview {
	AvatarView(image: "IMG_0455.jpeg", fallback: "Nicholas", size: .medium)
}
