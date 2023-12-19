import Foundation

extension Team {
    static var preview = Team(name: "Engineering", members: [], projects: [])
}

extension Project {
    static var preview = Project(name: "Hourglass", owner: .preview, team: .preview)
}

extension Member {
    static var preview = Member(name: "Nick Black", email: "nicholas.black98@icloud.com")
}

extension Section {
    static var preview = Section(name: "Backlog", order: 0, tasks: [Task(name: "Test", order: 0, assignee: .preview)])
}

extension Task {
    static var preview = [
        Task(name: "Look into frame accurate notes on video", order: 0, endDate: Date(), section: .preview, assignee: .preview),
        Task(name: "Write tests from user stories", order: 1, section: .preview, assignee: .preview),
        Task(name: "Look at best practices for public page viewing", order: 2, section: .preview, assignee: .preview),
    ]
}
