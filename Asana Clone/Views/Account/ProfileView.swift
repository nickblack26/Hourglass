//
//  ProfileView.swift
//  Asana Clone
//
//  Created by Nick on 7/5/23.
//

import SwiftUI

struct ProfileView: View {
	@State private var editProfile: Bool = false
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				HStack(alignment: .center) {
                    AvatarView(
                        image: tempUrl,
                        fallback: "Nick Black",
                        size: .xmega
                    )
					
					VStack(alignment: .leading) {
						Text("Nick Black")
							.font(.largeTitle)
						
						HStack {
							Label("11:14pm local time", systemImage: "clock")
							
							Label("nick@deepspacerobots", systemImage: "envelope")
						}
						.foregroundStyle(.secondary)
					}
				}
				
				HStack {
					Spacer()
					
					Button("Set out of office") {
						
					}
					.buttonStyle(.plain)
					.padding(.horizontal)
					.padding(.vertical, 10)
					.background {
						RoundedRectangle(cornerRadius: 5)
							.fill(.clear)
							.stroke(.gray)
					}
					
					Button("Edit Profile") {
						editProfile.toggle()
					}
					.buttonStyle(.plain)
					.padding(.horizontal)
					.padding(.vertical, 10)
					.background {
						RoundedRectangle(cornerRadius: 5)
							.fill(.blue)
					}
				}
				
				
				
				Grid(alignment: .top, horizontalSpacing: 25, verticalSpacing: 25) {
					GridRow {
						MyTasksWidget()
							.gridCellColumns(2)
						
						Grid(verticalSpacing: 25) {
							GridRow {
								VStack(alignment: .leading) {
									Text("About me")
										.font(.title2)
										.fontWeight(.bold)
									
									Text("Use this space to tell people about yourself.")
								}
								.padding()
								.frame(maxHeight: 400)
								.background {
									RoundedRectangle(cornerRadius: 10)
										.fill(.cardBackground)
										.stroke(.cardBorder, lineWidth: 1)
								}
							}
							
							GridRow {
								VStack(alignment: .leading) {
									Text("Frequent collaborators")
										.font(.title2)
										.fontWeight(.bold)
									
									Text("Use this space to tell people about yourself.")
								}
								.padding()
								.frame(maxHeight: 400)
								.background {
									RoundedRectangle(cornerRadius: 10)
										.fill(.cardBackground)
										.stroke(.cardBorder, lineWidth: 1)
								}
							}
						}
						.gridCellColumns(1)
					}
					
					GridRow {
						ProjectsWidget()
							.gridCellColumns(2)
					}
				}
				
				Spacer()
				
				
			}
		}
		.sheet(isPresented: $editProfile) {
			NavigationView {
				UserSettingsProfileModal()
					.toolbar {
						ToolbarItem(placement: .topBarTrailing) {
							Button {
								editProfile.toggle()
							} label: {
								Label("Close", systemImage: "xmark")
							}
						}
					}
			}
		}
	}
}

#Preview {
	ProfileView()
}
