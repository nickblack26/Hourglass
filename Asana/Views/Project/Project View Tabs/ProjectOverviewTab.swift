import SwiftUI
import SwiftData

struct ProjectOverviewTab: View {
    static var milestoneType: String { aTask.TaskType.milestone.rawValue }
    @Query(
        filter: #Predicate<aTask> { !$0.isCompleted && $0.taskType.rawValue == milestoneType }
    )
    private var milestones: [aTask]
	@State private var description: String = "This project is a personal project that will develop my SwiftUI skills."
	
	var body: some View {
		HStack(alignment: .top) {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Section {
                        TextView(
                            attributedText: .constant(
                                NSAttributedString(string: "")
                            )
                        )
                    } header: {
                        Text("Project description")
                            .font(.title2)
                            .fontWeight(.medium)
                    }
                    
                    Section {
                        Card(.constant(false)) {
                            HStack {
                                Image("shooting_target")
                                VStack {
                                    Text("Connect or create a goal to link this project to a larger purpose.")
                                    Menu {
                                        Button("Connect existing goal", systemImage: "triangle") {
                                            
                                        }
                                        
                                        Menu("Create new goal", systemImage: "plus") {
                                            Button("Blank goal") {
                                                
                                            }
                                            
                                            Button("Use goal templates") {
                                                
                                            }
                                        }
                                    } label: {
                                        HStack {
                                            Image(systemName: "triangle")
                                            Text("Add goal")
                                            Image(systemName: "chevron.down")
                                        }
                                    }
                                }
                            }
                        }
                    } header: {
                       Text("Connected goals")
                            .font(.title2)
                    }
                    
                    Section {
                        Card(.constant(false)) {
                            HStack {
                                Image("organization_structure")
                                VStack {
                                    Text("Connect a portfolio to link this project to a larger body of work.")
                                    Menu {
                                       
                                    } label: {
                                        HStack {
                                            Image(systemName: "folder")
                                            Text("Add to portfolio")
                                        }
                                    }
                                }
                            }
                        }
                    } header: {
                       Text("Connected portfolios")
                            .font(.title2)
                    }
                    
                    Section {
                        Card(.constant(false)) {
                            HStack {
                                Image("key_resources")
                                VStack {
                                    Text("Align your team around a shared vision with a project brief and supporting resources.")
                                    HStack {
                                        Menu {
                                           
                                        } label: {
                                            HStack {
                                                Image(systemName: "folder")
                                                Text("Create project brief")
                                            }
                                        }
                                        Menu {
                                           
                                        } label: {
                                            HStack {
                                                Image(systemName: "paperclip")
                                                Text("Add links & files")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } header: {
                       Text("Key resources")
                            .font(.title2)
                    }
                    
                    Section {
                        ForEach(milestones) { milestone in
                            Text(milestone.name)
                            Divider()
                        }
                        .listStyle(.plain)
                    } header: {
                       HStack {
                           Text("Milestones")
                                .font(.title2)
                           
                           Image(systemName: "plus")
                       }
                    }
                }
            }
		}
	}
}

#Preview {
	ProjectOverviewTab()
}
