import SwiftUI

fileprivate enum Tab: String, CaseIterable {
	case activity = "Activity"
	case archive = "Archive"
	case myMessages = "My Messages"
}

fileprivate enum Filter: String, CaseIterable {
    case all = "All"
    case fromPerson = "From Person"
    case assignedToMe = "Assigned to me"
    case mentioned = "@Mentioned"
    case assignedByMe = "Assigned by me"
}

fileprivate enum Sort: String, CaseIterable {
    case newest = "Newest"
    case relevance = "Relevance"
}

struct InboxView: View {
    @State private var selectedTab: Tab = .activity
    @State private var selectedFilter: Filter = .all
    @State private var selectedSort: Sort = .newest
    @State private var unreadOnly: Bool = true
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
                ForEach(Tab.allCases, id: \.self) {tab in
                    Button(tab.rawValue) {
                        withAnimation(.snappy) {
                            selectedTab = tab
                        }
                    }
                    .tint(tab == selectedTab ? .primary : .secondary)
                }
			}
			.padding(.horizontal)
			
			Divider()
			
			Grid {
                GridRow {
                    
                }
			}
			
			Spacer()
		}
		.navigationTitle("Inbox")
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button("Send message", systemImage: "square.and.pencil") {
                    
                }
                
                Menu("Expand", systemImage: "arrow.up.left.and.arrow.down.right") {
                    
                    
                }
                
                Menu("Filter", systemImage: "line.3.horizontal.decrease") {
                    Section {
                        Picker("Filter", selection: $selectedFilter) {
                           Text("All")
                                .tag(Filter.all)
                        }
                    }
                    
                    Section {
                        Picker("Filter", selection: $selectedFilter) {
                            Text("From Person")
                                .tag(Filter.fromPerson)
                            
                            Text("Assigned to me")
                                .tag(Filter.assignedToMe)
                            
                            Text("@Mentioned")
                                .tag(Filter.mentioned)
                            
                            Text("Assigned by me")
                                .tag(Filter.assignedByMe)
                        }
                    }
                    
                    Section {
                        Toggle("Unread only", isOn: $unreadOnly)
                    }
                }
                
                Menu("Sort: \(selectedSort.rawValue)", systemImage: "arrow.up.arrow.down") {
                    Picker("Filter", selection: $selectedSort) {
                        ForEach(Sort.allCases, id: \.self) { sort in
                            Text(sort.rawValue)
                                .tag(sort)
                        }
                    }
                }
            }
        }
	}
}

#Preview {
	NavigationStack {
		InboxView()
	}
}

