//
//  NewProjectView.swift
//  Asana Clone
//
//  Created by Nick on 6/30/23.
//

import SwiftUI

struct NewProjectView: View {
	@State private var step: Int = 0
	@Binding var isPresented: Bool
	
	var body: some View {
		VStack(spacing: 50) {
			VStack {
				Text("Create a new project")
					.font(.largeTitle)
				Text("How would you like to start?")
					.font(.title3)
			}
			
			HStack(spacing: 25) {
				NavigationLink {
					NewProjectSetup(isPresented: $isPresented)
				} label: {
					ProjectTile(image: nil, icon: "plus", title: "Blank project", subtitle: "Start from scratch")
				}
				.buttonStyle(.plain)
				
				NavigationLink {
					
				} label: {
					ProjectTile(image: "rocket", icon: nil, title: "Use a template", subtitle: "Choose from library")
				}
				.buttonStyle(.plain)
				
				NavigationLink {
					
				} label: {
					ProjectTile(image: "projectCreationImportCsv", icon: nil, title: "Import spreadsheet", subtitle: "Add from another tool")
				}
				.buttonStyle(.plain)
			}
		}
	}
}

#Preview {
	NavigationStack {
		NewProjectView(isPresented: .constant(true))
	}
}
