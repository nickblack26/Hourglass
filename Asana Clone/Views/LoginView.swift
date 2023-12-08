//
//  LoginView.swift
//  Asana Clone
//
//  Created by Nick on 6/22/23.
//

import SwiftUI

struct LoginView: View {
	@State private var email: String = ""
	@State private var password: String = ""
	
	var body: some View {
		HStack {
			Spacer()
			
			VStack {
				Spacer()
				
				VStack(spacing: 12) {
					Text("Welcome to Asana")
						.font(.largeTitle)
					
					Text("To get started, please sign in")
						.foregroundStyle(.secondary)
						.fontWeight(.bold)
						.font(.title3)
					
					Form {
						TextField("Email address", text: $email)
							.textFieldStyle(.roundedBorder)
							.autocorrectionDisabled()
							.textInputAutocapitalization(.never)
						
						SecureField("Password", text: $password)
							.textFieldStyle(.roundedBorder)
							.autocorrectionDisabled()
							.textInputAutocapitalization(.never)
						
						Button {
							
						} label: {
							Spacer()
							Text("Continue")
								.padding(.vertical, 7)
							Spacer()
						}
						.buttonStyle(.plain)
						.background(Color("paleBlue"))
						.foregroundStyle(.white)
						.cornerRadius(5)
					}
					.formStyle(.columns)
					.frame(maxWidth: 400)
					
					HStack {
						Text("Don't have an account?")
							.font(.subheadline)
							.foregroundStyle(.secondary)
						
						NavigationLink {
							VStack {
								Text("Signing Up")
							}
						} label: {
							Text("Sign up")
								.underline()
						}
						.foregroundStyle(.paleBlue)
					}
				}
				
				Spacer()
			}
			
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
	NavigationStack {
		LoginView()
	}
}
