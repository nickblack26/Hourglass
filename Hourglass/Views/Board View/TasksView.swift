import SwiftUI

struct TasksView: View {
    var tasks: [aTask]
    
    init(_ tasks: [aTask]) {
        self.tasks = tasks
		let testing: aTask = .init(name: "", order: 0)
//		matchedPredicates(obj: testing, predicates: [(\aTask.isCompleted, true)])

    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(tasks) { task in
                TaskCardView(task)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    TasksView([])
}
