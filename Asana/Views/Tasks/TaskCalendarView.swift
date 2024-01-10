import SwiftUI


struct TaskCalendarView: View {
    @Environment(\.modelContext) private var context
    @Environment(AsanaManager.self) private var asanaManager
    @State private var showWeekends: Bool = false
    @State private var showMultiDayTasks: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            Divider()
            
            HStack(spacing: 0) {
                ForEach(getCurrentWeeksDates(), id: \.self) { date in
                    let weekday = date.formatted(.dateTime.weekday(.abbreviated))
                    let day = date.formatted(.dateTime.day(.twoDigits))
                    
                    if let first = getCurrentWeeksDates().first, first == date  {
                        
                    } else {
                        Divider()
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 0) {
                        if !showWeekends && (weekday == "Sat" || weekday == "Sun") {
                            VStack(alignment: .leading, spacing: 16) {
                                Text(weekday.uppercased())
                                    .font(.title3)
                                    .foregroundStyle(.secondary)
                                    .fontWeight(.medium)
                                
                                Text(day)
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .padding(4)
                                    .background(weekday == Date.now.formatted(.dateTime.weekday(.abbreviated)) ? .accent : .clear)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            .padding()
                            
                        } else {
                            VStack(alignment: .leading, spacing: 16) {
                                Text(weekday.uppercased())
                                    .font(.title3)
                                    .foregroundStyle(.secondary)
                                    .fontWeight(.medium)
                                
                                Text(day)
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .padding(4)
                                    .background(weekday == Date.now.formatted(.dateTime.weekday(.abbreviated)) ? .accent : .clear)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        }
                        
                        Divider()
                            .background(.white)
                        
                        ScrollView {
                            Button("Add task", systemImage: "plus") {
//                                let task = Task(name: "", order: sections?[0].tasks?.count ?? 0)
//                                currentMember.sections?[0].tasks?.append(task)
                            }
                            .buttonStyle(.plain)
                            .foregroundStyle(.secondary)
                            .fontWeight(.semibold)
                            .padding(.top, 32)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                        .background(Color(uiColor: .systemGray6).opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    TaskCalendarView()
}
