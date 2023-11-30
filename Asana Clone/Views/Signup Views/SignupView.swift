//
//  SignupView.swift
//  Asana Clone
//
//  Created by Nick on 6/26/23.
//

import SwiftUI

struct SignupView: View {

	@State private var email: String = ""
	@FocusState private var nameInFocus: Bool
	
    var body: some View {
		HStack {
			Spacer()
			
			VStack {
				Spacer()
				
				VStack {
					Spacer()
					
					Text("You’re one click away\nfrom less busywork")
						.font(.system(size: 45))
						.multilineTextAlignment(.center)
					
					Text("By signing up, I agree to the Asana Privacy Policy and Terms of Service.")
						.foregroundStyle(.secondary)
						.font(.footnote)
					
					Form {
						TextField("Email address", text: $email)
							.font(.title3)
							.padding()
							.presentationCornerRadius(4)
							.border(nameInFocus ? .brand : .secondary.opacity(0.25), width: 2)
							.autocorrectionDisabled()
							.textInputAutocapitalization(.never)
							.tint(.brand)
							.focused($nameInFocus)
						
						Button {
							
						} label: {
							Spacer()
							
							Text("Sign up")
								.font(.title3)
								.fontWeight(.medium)
								.padding()
								
							Spacer()
						}
						.buttonStyle(.plain)
						.background(.black)
						.foregroundStyle(.white)
						.cornerRadius(4)
					}
					.formStyle(.columns)
					.padding(.horizontal, 50)
					.padding(.top, 25)
					
					Spacer()
					
					HStack {
						HStack {
							Image(systemName: "checkmark.circle")
								.foregroundStyle(.secondary)
								.font(.largeTitle)
							
							Text("Get access to unlimited tasks, projects, and storage.")
								.font(.footnote)
						}
						
						HStack {
							Image(systemName: "checkmark.circle")
								.foregroundStyle(.secondary)
								.font(.largeTitle)
							
							Text("See different views like list, board, and calendar.")
								.font(.footnote)
						}
						
						HStack {
							Image(systemName: "checkmark.circle")
								.foregroundStyle(.secondary)
								.font(.largeTitle)
							
							Text("Invite your teammates to explore Asana.")
								.font(.footnote)
						}
					}
					
					Spacer()
				}
				
				Spacer()
			}
			.frame(maxWidth: 700)
			
			Spacer()
		}
		.overlay(alignment: .topLeading) {
			Image("logo")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(height: 25)
			
		}
		.padding()
    }
}

#Preview {
	SignupView()
}
