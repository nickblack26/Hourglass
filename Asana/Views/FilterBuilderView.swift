import SwiftUI

struct FilterModel: Hashable {
    var name: String
    var filters: [KeyPathComparator<aTask>]
}

var quickFilters: [FilterModel] = [
    .init(name: "Incomplete tasks", filters: []),
    .init(name: "Completed tasks", filters: []),
    .init(name: "Due this week", filters: []),
    .init(name: "Due next week", filters: []),
]

struct FilterBuilderView: View {
    @State private var filters: [FilterModel] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            SwiftUI.Section("Quick filters") {
                HStack {
                    ForEach(quickFilters, id: \.self) { filter in
                        Button(filter.name) { }
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.clear)
                                    .strokeBorder(.secondary, style: .init(lineWidth: 1))
                            }
                    }
                }
                .buttonStyle(.bordered)
                .tint(.clear)
                .foregroundStyle(.primary)
                
            }
            
            ForEach(filters, id: \.self) { filter in
                SwiftUI.Section(filter.name) {
                    
                }
            }
                        
            Menu {
               
//                guard let properties = try? emptyTask.allProperties() else { [] }
//                ForEach(mirror.children, id: \.self) { (property, value) in
//                    Text(property ?? "")
//                }
            } label: {
                HStack {
                    Image(systemName: "plus")
                        .imageScale(.small)
                        
                    Text("Add filter")
                    
                    Image(systemName: "chevron.down")
                        .imageScale(.small)
                }
            }
            
            Divider()
            
            VStack(alignment: .trailing) {
                Button("Clear all") {
                    
                }
                .buttonStyle(.bordered)
                .tint(.clear)
                .foregroundStyle(.primary)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.clear)
                        .strokeBorder(.secondary, style: .init(lineWidth: 1))
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    FilterBuilderView()
}
