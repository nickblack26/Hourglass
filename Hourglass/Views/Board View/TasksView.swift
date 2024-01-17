//
//  TasksView.swift
//  Asana
//
//  Created by Nick Black on 1/13/24.
//

import SwiftUI

struct TasksView: View {
    var tasks: [aTask]
    
    init(_ tasks: [aTask]) {
        self.tasks = tasks
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(tasks) { task in
                @Bindable var task = task
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
