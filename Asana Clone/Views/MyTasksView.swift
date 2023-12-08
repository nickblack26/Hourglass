import SwiftUI
import SwiftData

enum MyTaskTab: String, CaseIterable, Identifiable {
	var id: Self {
		return self
	}
	
	case list = "List"
	case board = "Board"
	case calendar = "Calendar"
}

struct MyTasksView: View {
    @Query var sections: [SectionModel]
	@State private var tabProgress: CGFloat = 0
	@State private var selectedTab: MyTaskTab? = .list
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Image("profile")
					.resizable()
					.scaledToFill()
					.frame(width: 72, height: 72)
					.cornerRadius(50)
				
				VStack(alignment: .leading) {
					Text("My tasks")
					
					
					HStack(spacing: 0) {
						ForEach(MyTaskTab.allCases) { tab in
							Button(tab.rawValue) {
								withAnimation {
									selectedTab = tab
								}
							}
							.padding(.horizontal)
						}
					}
					.background {
						GeometryReader {
							let size = $0.size
							let lineWidth = size.width / CGFloat(MyTaskTab.allCases.count)
							
							Capsule()
								.frame(
									width: lineWidth,
									height: 2
								)
								.frame(
									maxHeight: .infinity,
									alignment: .bottom
								)
								.offset(
									x: tabProgress * (size.width - lineWidth)
								)
						}
					}
				}
				
				Spacer()
				
				Button("Share", systemImage: "lock.fill") {
					
				}
				
				Divider()
					.frame(maxHeight: 50)
				
				Button("Share", systemImage: "lock.fill") {
					
				}
			}
			.padding(.horizontal)
			.padding(.top)
			
			Divider()
			
			ScrollView(.horizontal) {
				LazyHStack(spacing: 16) {
					TaskTableView(sections)
						.containerRelativeFrame(.horizontal)
					
					TaskBoardView([])
						.containerRelativeFrame(.horizontal)
					
					Text("Hello")
						.containerRelativeFrame(.horizontal)
				}
			}
			.scrollPosition(id: $selectedTab)
			.scrollIndicators(.hidden)
			.scrollTargetBehavior(.paging)
		}
//		.toolbar {
//			EditButton()
//		}
	}
}

#Preview {
	return NavigationStack {
		MyTasksView()
	}
}

