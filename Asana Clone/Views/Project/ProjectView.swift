import SwiftUI

struct ProjectView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AsanaManager.self) private var asanaManager
    @State private var selectedTab: ProjectTab = .board
	@State private var showProjectSheet: Bool = false
	@Bindable var project: ProjectModel
	
	init(_ project: ProjectModel) {
		let defaultView: ProjectTab = ProjectTab(rawValue: "List") ?? .list
		self._selectedTab = State(initialValue: defaultView)
		self.project = project
	}
	
	var body: some View {
		VStack(alignment: .leading) {
            ProjectHeader(selectedTab: $selectedTab, project: project)
            
            HStack {
                Button("Add task", systemImage: "plus", action: addNewTask)
                .tint(.accent)
                .buttonStyle(.borderedProminent)
                
                Menu("", systemImage: "chevron.down") {
                    Button("Add section") {
                        showProjectSheet.toggle()
                    }
                    Button("Add milestone...", action: addNewSection)
                }
                .labelsHidden()
                .buttonStyle(.borderedProminent)
                .tint(.clear)
                .foregroundStyle(.primary)
                
                Spacer()
                
               
            }
            .padding(.horizontal)
			
			TabView(selection: $selectedTab) {
				ProjectOverviewTab()
					.tag(ProjectTab.overview)
				
                TaskTableView(project.sections?.sorted(by: { $0.order < $1.order }) ?? [])
                .tag(ProjectTab.list)
                .padding()
				
                TaskBoardView(project.sections?.sorted(by: { $0.order < $1.order }) ?? [])
					.tag(ProjectTab.board)
					.padding()
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
		}
        .sheet(isPresented: $showProjectSheet, content: {
            NewSectionForm(showProjectSheet: $showProjectSheet, project: project)
        })
	}
    
    private func addNewSection() {
        let section = SectionModel(name: "", order: 0)
        if let sections = project.sections, !sections.isEmpty {
            for index in sections.indices {
                @Bindable var section = sections[index]
                section.order = index + 1
            }
            project.sections!.insert(section, at: 0)
        } else {
            project.sections?.append(section)
        }
    }
    
    private func addNewTask() {
        if let assignee = asanaManager.currentMember {
            let task = TaskModel(name: "New task", assignee: assignee)
            modelContext.insert(task)
            print("added task \(task)")
            if project.tasks.isEmpty {
                project.sections?[0].tasks.append(task)
            } else {
                project.sections?[0].tasks.insert(task, at: 0)
            }
        }
    }
}

#Preview {
    ProjectView(.preview)
}
