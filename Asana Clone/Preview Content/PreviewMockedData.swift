import Foundation

extension TeamModel {
    static var preview = TeamModel(name: "Engineering", members: [], projects: [])
}

extension ProjectModel {
    static var preview = ProjectModel(name: "Hourglass", owner: .preview, team: .preview)
}

extension MemberModel {
    static var preview = MemberModel(name: "Nick Black", email: "nicholas.black98@icloud.com")
}

extension SectionModel {
    static var preview = SectionModel(name: "Backlog", tasks: [TaskModel(name: "Test", assignee: .preview)])
}

extension TaskModel {
    static var preview = [
        TaskModel(name: "Look into frame accurate notes on video", section: .preview, assignee: .preview),
        TaskModel(name: "Write tests from user stories", section: .preview, assignee: .preview),
        TaskModel(name: "Look at best practices for public page viewing", section: .preview, assignee: .preview),
    ]
}
