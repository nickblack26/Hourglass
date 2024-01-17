import SwiftUI
import SwiftData


struct StatusUpdateBuilder: View {
    @Bindable var statusUpdate: StatusUpdate
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            StatusUpdateHeader()
            
            Section {
                HStack {
                    Form {
                        TextField(
                            "Title",
                            text: $statusUpdate.title,
                            prompt: Text(
                                "Status update - \(Date.now.formatted(date: .abbreviated, time: .omitted))"
                            )
                        )
                        .font(.title)
                        .fontWeight(.medium)
                        
                        Picker("Status", selection: $statusUpdate.statusType) {
                            ForEach(StatusType.allCases, id: \.self) { update in
                                Text(update.rawValue)
                            }
                        }
                        
                        Divider()
                        
                        ForEach(statusUpdate.sections) { section in
                            StatusSectionView(section: section)
                        }
                    }
                    .onSubmit() {
                        if statusUpdate.title.isEmpty {
                            statusUpdate.title = "Status update - \(Date.now.formatted(date: .abbreviated, time: .omitted))"
                        }
                    }
                    .formStyle(.columns)
                }
                .padding([.leading, .top])
            } header: {
                Rectangle()
                    .fill(.green)
                    .frame(height: 4)
            }
            
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .onAppear {
//            if statusUpdate.sections.isEmpty {
//                let summary: StatusSection = .init(name: "Summary")
//                statusUpdate.sections.append(summary)
//            }
        }
    }
    
}


#Preview {
    let statusUpdate = StatusUpdate(title: "")
    
    return StatusUpdateBuilder(statusUpdate: statusUpdate)
//        .modelContainer(for: fullSchema, inMemory: true)
//    StatusUpdateBuilder()
}
