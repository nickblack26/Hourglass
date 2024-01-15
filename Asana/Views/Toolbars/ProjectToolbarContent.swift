import SwiftUI

struct ProjectToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .primaryAction) {
            Button("Edit project details", systemImage: "pencil") {
                
            }
        }
    }
}

#Preview {
    VStack {
        
    }
    .toolbar {
        ProjectToolbar()
    }
    .toolbarRole(.editor)
}
