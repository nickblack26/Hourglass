//
//  NotificationView.swift
//  Asana Clone
//
//  Created by Nick on 6/26/23.
//

import SwiftUI

//let yeti = PublicUsersModel(id: UUID(), name: "Yeti", profile_image_url: "yeti")
//
//struct PublicNotificationsModel: Codable {
//	var title: String
//	var profile_image: String?
//	var profile: Member?
//	var content: String?
//	var created_at: Date
//}

//struct NotificationDetail: Codable {
//	var icon: String
//	var notification: PublicNotificationsModel
//}

enum NotificationType: CaseIterable {
	case task
	case information
	case comment
	
//	var details: NotificationDetail {
//		switch self {
//			case .task: return .init(icon: "star.square", notification: .init(title: "Your tasks for today", created_at: Date()))
//			case .information: return .init(icon: "message", notification: .init(title: "Teamwork makes work happen!",profile: yeti, content: "Inbox is where you get updates, notifications, and messages from your teammates. Send an invite to start collaborating.", created_at: Date()))
//			case .comment: return .init(icon: "star.square", notification: .init(title: "Teamwork makes work happen!", created_at: Date()))
//				
//		}
//	}
}

struct NotificationView: View {
	let type: NotificationType
	@State private var isHovering: Bool = false
	
	var body: some View {
		ZStack(alignment: .topTrailing) {
//			VStack(alignment: .leading, spacing: 15) {
//				Label(type.details.notification.title, systemImage: type.details.icon)
//				
//				HStack(alignment: .top, spacing: 15) {
//					if(type.details.notification.profile?.profile_image_url != nil) {
//						Image(type.details.notification.profile?.profile_image_url ?? "")
//							.resizable()
//							.scaledToFill()
//							.frame(width: 35, height: 35)
//							.cornerRadius(50)
//					}
//					
//					VStack(alignment: .leading, spacing: 5) {
//						if(type.details.notification.profile != nil) {
//							Text(type.details.notification.profile?.name ?? "")
//								.fontWeight(.medium)
//						}
//						
//						Text(type.details.notification.content ?? "")
//						
//						if(type != .task) {
//							Text("4 days ago")
//								.font(.caption)
//								.foregroundStyle(.secondary)
//						}
//					}
//				}
//				
//			}
//			.listRowBackground(EmptyView())
//			
//			if (isHovering) {
//				HStack {
//					Button {
//						
//					} label: {
//						Image(systemName: "bookmark")
//					}
//					.padding(10)
//					
//					Button {
//						
//					} label: {
//						Image(systemName: "app.badge")
//					}
//					.padding(10)
//					
//					Button {
//						
//					} label: {
//						Image(systemName: "archivebox")
//					}
//					.padding(10)
//				}
//				.padding(.horizontal, 5)
//				.background {
//					RoundedRectangle(cornerRadius: 10)
//						.fill(Color("CardBackground"))
//						.stroke(Color("CardBorder"), lineWidth: 1)
//				}
//				.foregroundStyle(.gray)
//			}
		}
		.background(isHovering ? Color("CardBackground") : .clear)
		.onHover(perform: { hovering in
			isHovering = hovering
#if targetEnvironment(macCatalyst)
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
	NotificationView(type: .information)
}
