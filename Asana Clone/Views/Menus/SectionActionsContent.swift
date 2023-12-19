import SwiftUI

struct SectionActionsContent: View {
    @Environment(\.modelContext) private var context
    @Environment(AsanaManager.self) private var asanaManager
    var viewType: Project.Tab
    @Binding var sections: [Section]
    @Bindable var section: Section

    var body: some View {
        Button("Add rule to section", systemImage: "bolt") {
            
        }
        
        Button("Rename section", systemImage: "pencil") {
            
        }
        
        Menu("Add section", systemImage: "lines.measurement.vertical") {
            let firstSection: String = viewType == .board ? "left" : "above"
            let firstSectionArrow: String = viewType == .board ? "arrow.left" : "arrow.up"
            let secondSection: String = viewType == .board ? "right" : "below"
            let secondSectionArrow: String = viewType == .board ? "arrow.right" : "arrow.down"
            let index = sections.firstIndex(of: section)
            
            Button("Add section to \(firstSection)", systemImage: firstSectionArrow) {
                addSectionBefore(currentIndex: index ?? 0)
            }
            
            Button("Add section to \(secondSection)", systemImage: secondSectionArrow) {
                addSectionAfter(currentIndex: index ?? 0)
            }
        }
        
        Button("Delete section", systemImage: "trash", role: .destructive) {
            
        }
    }
    
    private func addTaskToSection(_ section: Section) {
        if let currentMember = asanaManager.currentMember {
            let task = Task(name: "", order: section.tasks.count, assignee: currentMember)
            section.tasks.insert(task, at: 0)
        }
    }
    
    private func addSectionBefore(currentIndex: Int) {
        if currentIndex == 0 {
            let newSection = Section(name: "", order: 0)
            context.insert(newSection)
            sections.insert(newSection, at: 0)
        } else {
            let newSection = Section(name: "", order: currentIndex - 1)
            context.insert(newSection)
            sections.insert(newSection, at: currentIndex - 1)
        }
    }
    
    private func addSectionAfter(currentIndex: Int) {
        let newSection = Section(name: "", order: currentIndex + 1)
        context.insert(newSection)
        sections.insert(newSection, at: currentIndex + 1)
    }
}

#Preview {
    SectionActionsContent(viewType: .board, sections: .constant([]), section: .preview)
}
