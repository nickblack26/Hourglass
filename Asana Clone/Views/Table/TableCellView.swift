//
//  TableCellView.swift
//  Asana Clone
//
//  Created by Nick on 7/17/23.
//

import SwiftUI

struct TableCellView: View {
	@State private var isHovering: Bool = false
	@State private var isBorderHovering: Bool = false
	@State private var width: CGFloat?
	var isFirst: Bool
	var text: String
	var isLast: Bool
	var isHeader: Bool
	
	init(width: CGFloat, isFirst: Bool, text: String, isLast: Bool, isHeader: Bool) {
		self.width = width
		self.isFirst = isFirst
		self.text = text
		self.isLast = isLast
		self.isHeader = isHeader
	}
	
	init(isFirst: Bool, text: String, isLast: Bool, isHeader: Bool) {
		self.width = nil
		self.isFirst = isFirst
		self.text = text
		self.isLast = isLast
		self.isHeader = isHeader
	}
	
	var body: some View {
		HStack {
			if !isFirst {
				Divider()
					.onHover(perform: { hovering in
						isBorderHovering = hovering
					})
			}
			
			HStack(spacing: 0) {
				Text(text)
				
				if isHeader {
					Menu {
						Label("Sort ascending", systemImage: "arrow.up.and.down.text.horizontal")
						Label("Sort descending", systemImage: "arrow.up.and.down.text.horizontal")
						
						Divider()
						
						Button("Move left") {
							
						}
						
						Button("Move right") {
							
						}
						
						Menu {
							Button("Narrow") {
								
							}
							
							Button("Wide") {
								
							}
							
						} label: {
							Text("Set column width")
						}
						
						Button("Hide column") {
							
						}
						
					} label: {
						Image(systemName: "chevron.down.square")
							.frame(maxWidth: .infinity, alignment: .trailing)
					}
				} else {
					Button {
						
					} label: {
						Image(systemName: "chevron.right")
					}
				}
			}
			.padding()
			
			
			if !isLast {
				Divider()
					.onHover(perform: { hovering in
						isBorderHovering = hovering
					})
					.frame(width: isBorderHovering ? 5 : 0)
					.tint(isBorderHovering ? .blue : .secondary)
			}
		}
		.frame(idealWidth: (width != nil) ? width! : nil, maxWidth: 800, alignment: .leading)
		.onHover { hovering in
			isHovering = hovering
		}
	}
}

#Preview {
	TableCellView(isFirst: true, text: "Task name", isLast: true, isHeader: true)
}
