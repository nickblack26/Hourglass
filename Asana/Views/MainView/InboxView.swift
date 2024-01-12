import SwiftUI

enum InboxTab: CaseIterable {
	case activity
	case archive
	case myMessages
}

struct InboxView: View {
	@State private var currentTab: InboxTab = .activity
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				NavigationLink("Activity", value: InboxTab.activity)
					.opacity(currentTab == InboxTab.activity ? 1.0 : 0.5)
					.underline(currentTab == InboxTab.activity)
				
				NavigationLink("Archive", value: InboxTab.archive)
					.opacity(currentTab == InboxTab.archive ? 1.0 : 0.5)
					.underline(currentTab == InboxTab.archive)
				
				Divider()
					.frame(maxHeight: 25)
				
				NavigationLink("Messages I've sent", value: InboxTab.myMessages)
					.opacity(currentTab == InboxTab.myMessages ? 1.0 : 0.5)
					.underline(currentTab == InboxTab.myMessages)
				
				Spacer()
			}
			.padding(.horizontal)
			
			Divider()
			
			HStack {
				Spacer()
				
				VStack {
					HStack {
						Button {
							
						} label: {
							Label("Customize", systemImage: "square.and.pencil")
						}
						.buttonStyle(.plain)
						.padding(.horizontal)
						.padding(.vertical, 10)
						.background {
							RoundedRectangle(cornerRadius: 5)
								.stroke(.cardBorder, lineWidth: 1)
						}
						
						Spacer()
						
						Button {
							
						} label: {
							Label("Expand", systemImage: "arrow.up.left.and.arrow.down.right")
						}
						.buttonStyle(.plain)
						.padding(.horizontal)
						
						Button {
							
						} label: {
							Label("Filter", systemImage: "line.3.horizontal.decrease")
						}
						.buttonStyle(.plain)
						.padding(.horizontal)
						
						Button {
							
						} label: {
							Label("Sort: Relevance", systemImage: "arrow.up.arrow.down")
						}
						.buttonStyle(.plain)
						.padding(.horizontal)
						
						Button {
							
						} label: {
							Image(systemName: "ellipsis")
						}
						.buttonStyle(.plain)
						.padding(.horizontal)
					}
					.padding()
					
					Divider()
					
					Spacer()
				}
				
				Divider()
				
				VStack {
					Spacer()
				}
				
				Spacer()
			}
			
			Spacer()
		}
		.navigationTitle("Inbox")
		.foregroundStyle(.primary)
	}
}

#Preview {
	NavigationStack {
		InboxView()
	}
}

