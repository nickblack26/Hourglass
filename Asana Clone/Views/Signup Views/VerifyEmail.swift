//
//  VerifyEmail.swift
//  Asana Clone
//
//  Created by Nick on 6/26/23.
//

import SwiftUI

struct VerifyEmail: View {
	var body: some View {
		HStack {
			Spacer()
			
			VStack {
				Spacer()
				
				VStack(spacing: 25) {
					Text("Please verify your email")
						.font(.system(size: 45))
						.fontWeight(.ultraLight)
						.multilineTextAlignment(.center)
					
					Text("Once you verify your email address, you\nand your team can get started in Asana.")
						.foregroundStyle(.secondary)
						.font(.footnote)
						.multilineTextAlignment(.center)
					
					Button {
						
					} label: {
						HStack {
							Image(systemName: "envelope.open.fill")
								.foregroundStyle(.paleBlue)
							Text("Open Mail")
								.foregroundStyle(.secondary)
						}
						.padding(.horizontal)
						.padding(.vertical, 10)
						.border(.secondary.opacity(0.5), width: 2)
						
					}
					.buttonStyle(.plain)
					
					HStack {
						Text("Didn't receive an email?")
							.foregroundStyle(.secondary)
						Button {
							
						} label: {
							Text("Resend Email.")
								.fontWeight(.medium)
						}
						.buttonStyle(.plain)
					}
					
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
	VerifyEmail()
}
