import SwiftUI

struct NewProjectSetup: View {
    @Environment(\.modelContext) var modelContext
	@State private var showNextSteps: Bool = false
	@State private var name: String = "Test"
	@State private var privacy: PrivacyStatus = .publicToTeam
	@State private var defaultView: TaskViewChoice = .list
	@State private var nextStep: FirstStep = .tasks
	@Binding var isPresented: Bool

	var body: some View {
		GeometryReader { geometry in
			HStack {
				if(!showNextSteps) {
					Form {
						Section("Project name") {
							TextField("", text: $name)
						}
						
						Section("Privacy") {
							Picker("Privacy" ,selection: $privacy) {
								ForEach(PrivacyStatus.allCases, id: \.self) { status in
									Text(status.rawValue)
								}
							}
							.labelsHidden()
							.pickerStyle(.inline)
						}
						
						
						Section("Default view") {
							Picker("Default view" ,selection: $defaultView) {
								ForEach(TaskViewChoice.allCases, id: \.self) { view in
									HStack {
										Image("nux_project_\(view)")
											.resizable()
											.frame(width: 35, height: 35)
										Text(view.rawValue)
										Spacer()
										
									}
									
									.padding()
									.background {
										RoundedRectangle(cornerRadius: 10)
											.fill(defaultView == view ? .accent.opacity(0.05) : .clear)
											.stroke(defaultView == view ? .accent : .secondary.opacity(0.25), lineWidth: 1.0)
									}
								}
							}
							.labelsHidden()
							.pickerStyle(.inline)
						}
						
						Button {
							showNextSteps.toggle()
						} label: {
							Text("Continue")
						}
						.disabled(name.isEmpty)
					}
				} else {
					VStack(spacing: 30) {
						VStack(spacing: 15) {
							ForEach(FirstStep.allCases, id: \.self) { step in
								Button {
									nextStep = step
								} label: {
									HStack {
										Image(step.details.0)
											.resizable()
											.frame(width: 35, height: 35)
										
										VStack(alignment: .leading) {
											Text(step.details.1)
												.foregroundStyle(.primary)
											Text(step.details.2)
												.foregroundStyle(.secondary)
										}
										Spacer()
									}
									.padding()
									.background {
										RoundedRectangle(cornerRadius: 10)
											.fill(nextStep == step ? .accent.opacity(0.1) : .clear)
											.stroke(nextStep == step ? .accent : .secondary)
									}
								}
								.buttonStyle(.plain)
							}
						}
						
						Button {
							createProject()
						} label: {
							Spacer()
							Text("Go to project")
								.padding(.vertical, 10)
								.fontWeight(.medium)
							Spacer()
						}
						.buttonStyle(.plain)
						.background(Color("paleBlue"))
						.foregroundStyle(.white)
						.cornerRadius(5)
						
						Spacer()
					}
					.padding()
				}
				ZStack(alignment: .topLeading) {
					GeometryReader{g in
						let value = g.frame(in: .local)
						
						Image(defaultView.image)
							.resizable()
							.imageScale(.large)
							.aspectRatio(contentMode: .fill)
						
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
						.offset(x: value.width / 7, y: value.height / 30)
						
						if(defaultView == .list || defaultView == .board) {
							Text("To do")
								.font(.title2)
								.fontWeight(.medium)
								.padding(.top, 107)
								.padding(.leading, 25)
							
							Text("In progess")
								.font(.title2)
								.fontWeight(.medium)
								.padding(.top, defaultView == .list ? 285 : 107)
								.padding(.leading, defaultView == .list ? 25 : 375)
							
							Text("Complete")
								.font(.title2)
								.fontWeight(.medium)
								.padding(.top, defaultView == .list ? 410 : 107)
								.padding(.leading, defaultView == .list ? 25 : 725)
						}
					}
				}
				.background(.green)
				.frame(width: geometry.size.width * 0.5, alignment: .leading)
				.clipped()
			}
		}
		.navigationTitle(showNextSteps ? "What do you want to do first?" : "New Project")
		.navigationBarTitleDisplayMode(.large)
	}
	
	private func createProject() {
        let newProject = ProjectModel(name: name, owner: .preview, team: .preview)
        modelContext.insert(newProject)
	}
}

#Preview {
	NavigationStack {
		NewProjectSetup(isPresented: .constant(false))
	}
}
