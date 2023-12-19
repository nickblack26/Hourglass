import SwiftUI

struct NewProjectSetup: View {
    @Environment(AsanaManager.self) private var asanaManager
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showNextSteps: Bool = false
    @State private var name: String = "Testing"
    @State private var privacy: Project.Privacy = .publicToTeam
    @State private var defaultView: Project.Tab = .list
    @State private var nextStep: Project.FirstStep = .tasks
    @Binding var isPresented: Bool
    
    var body: some View {
        @Bindable var asanaManager = asanaManager
        Grid {
            GridRow {
                VStack(alignment: .leading, spacing: 32) {
                    SwiftUI.Section {
                        TextField("Project name", text: $name)
                            .textFieldStyle(.roundedBorder)
                    } header: {
                        Text("Project name")
                    } footer: {
                        if name.isEmpty {
                            Text("Project name is required.")
                                .foregroundStyle(.red)
                        }
                    }
                    
                    SwiftUI.Section("Privacy") {
                        Picker("Privacy" ,selection: $privacy) {
                            ForEach(Project.Privacy.allCases, id: \.self) { status in
                                Text(status.rawValue)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(.menu)
                    }
                    
                    SwiftUI.Section("Default view") {
                        let views: [Project.Tab] = [.list, .board, .timeline, .calendar]
                        
                        Grid {
                            GridRow {
                                ForEach(views, id: \.self) { view in
                                    Button {
                                        defaultView = view
                                    } label: {
                                        VStack {
                                            Image("nux_project_\(view)")
                                                .resizable()
                                                .frame(width: 35, height: 35)
                                            
                                            Text(view.rawValue)
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(defaultView == view ? .accent.opacity(0.05) : .clear)
                                                .stroke(defaultView == view ? .accent : .secondary.opacity(0.25), lineWidth: 1.0)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Button {
                        createProject()
                    } label: {
                        Text("Create project")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.accent)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                .padding()
                .gridCellColumns(1)
                
                Image(defaultView.image)
                    .resizable()
                    .scaledToFit()
                    .gridCellColumns(2)
                    .overlay(alignment: .topLeading) {
                        GeometryReader {
                            let size = $0.size
                            
                            VStack(alignment: .leading) {
                                Text(name)
                                
                                HStack {
                                    Text("Overview")
                                    
                                    Text("List")
                                        .underline(defaultView == .list, color: .accentColor)
                                        .foregroundStyle(defaultView == .list ? .accent : .secondary)
                                    
                                    Text("Board")
                                        .underline(defaultView == .board, color: .accentColor)
                                        .foregroundStyle(defaultView == .board ? .accent : .secondary)
                                    Text("Timeline")
                                        .underline(defaultView == .timeline, color: .accentColor)
                                        .foregroundStyle(defaultView == .timeline ? .accent : .secondary)
                                    Text("Calendar")
                                        .underline(defaultView == .calendar, color: .accentColor)
                                        .foregroundStyle(defaultView == .calendar ? .accent : .secondary)
                                    Text("Workflow")
                                }
                                .foregroundStyle(.secondary)
                                .fontWeight(.medium)
                            }
                            .offset(x: size.width * 0.07, y: size.height * 0.035)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        }
                    }
                    .overlay(alignment: .topLeading) {
                        GeometryReader {
                            let size = $0.size
                            VStack(alignment: .leading, spacing: 0) {
                                if(defaultView == .list || defaultView == .board) {
                                    Text("To do")
                                        .font(.title2)
                                        .fontWeight(.medium)
                                        .offset(y: size.height * 0.16)
                                    
                                    Text("In progess")
                                        .font(.title2)
                                        .fontWeight(.medium)
                                        .offset(y: size.height * 0.395)
                                    
                                    Text("Complete")
                                        .font(.title2)
                                        .fontWeight(.medium)
                                        .offset(y: size.height * 0.555)
                                }
                            }
                            .offset(x: size.width * 0.026)
                        }
                    }
            }
        }
        .navigationTitle(showNextSteps ? "What do you want to do first?" : "New Project")
    }
    
    private func createProject() {
        guard let currentTeam = asanaManager.currentTeam else { return }
        guard let currentMember = asanaManager.currentMember else { return }
        
        let newSection = Section(name: "", order: 0)
        modelContext.insert(newSection)
        
        let newProject = Project(
            name: name,
            owner: currentMember,
            team: currentTeam,
            sections: [],
            defaultTab: defaultView
        )
        modelContext.insert(newProject)
        
        newProject.sections?.append(newSection)
        
        asanaManager.selectedLink = .project(newProject)
        
        dismiss()
    }
}

#Preview {
    @State var asanaManager = AsanaManager()
    
    return NavigationStack {
        NewProjectSetup(isPresented: .constant(false))
    }
    .environment(asanaManager)
}
