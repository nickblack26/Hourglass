import SwiftUI

struct TaskToolbarContent: ToolbarContent {
    @Binding var sort: TaskSortOption
    @Binding var group: TaskGroupBy
    @Binding var defaultView: MyTaskTab
    @Binding var selectedTab: MyTaskTab
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarLeading) {
            ForEach(MyTaskTab.allCases) { tab in
                let isSelected = selectedTab == tab
                Button(
                    tab.rawValue,
                    systemImage: tab.icon
                ) {
                    withAnimation(.snappy) {
                        selectedTab = tab
                    }
                }
                .tint(isSelected ? .accent : .secondary)
            }
        }
        
        ToolbarItemGroup(placement: .primaryAction) {
            Menu("Customize", systemImage: "square.grid.2x2") {
                Button("Fields", systemImage: "character.textbox") {
                    
                }
                .badge(10)
                
                Button("Rules", systemImage: "bolt") {
                    
                }
                
                Button("Apps", systemImage: "apple.terminal.on.rectangle") {
                    
                }
            }
            
            Menu("More", systemImage: "ellipsis.circle") {
                Button("Sync to calendar", systemImage: "calendar") {
                    
                }
                
                Button("Add tasks via Email", systemImage: "envelope") {
                    
                }
                
                Button("Export CSV", systemImage: "square.and.arrow.up") {
                    
                }
                
                Button("Sync to Google Sheets", systemImage: "doc.text") {
                    
                }
                
                Button("Print", systemImage: "printer") {
                    
                }
                
                Menu(
                    "Default view",
                    systemImage: "viewfinder"
                ) {
                        Picker(
                            "Default view",
                            systemImage: "viewfinder",
                            selection: $defaultView
                        ) {
                            ForEach(MyTaskTab.allCases) {
                                Text($0.rawValue)
                                    .tag($0)
                            }
                        }
                    }
                
                Menu(
                    "Group by",
                    systemImage: "square.on.square.squareshape.controlhandles"
                ) {
                    Picker(
                        "Group by",
                        systemImage: "square.on.square.squareshape.controlhandles",
                        selection: $group
                    ) {
                        ForEach(TaskGroupBy.allCases) {
                            Text($0.rawValue)
                                .tag($0)
                        }
                    }
                }
                
                
                Menu(
                    "Sort",
                    systemImage: "arrow.up.arrow.down"
                ) {
                    Picker(
                        "Sort",
                        systemImage: "arrow.up.arrow.down",
                        selection: $sort
                    ) {
                        ForEach(TaskSortOption.allCases) {
                            Text($0.rawValue)
                                .tag($0)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    VStack {
        
    }
    .toolbar {
        TaskToolbarContent(
            sort: .constant(.creationDate),
            group: .constant(.createdBy),
            defaultView: .constant(.board),
            selectedTab: .constant(.board)
        )
    }
}
