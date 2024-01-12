import SwiftUI

struct StatusSectionView: View {
    @State private var isHovering: Bool = false
    var section: StatusSection
    var body: some View {
        HStack(alignment: .top) {
            Image("DragIcon")
                .resizable()
                .frame(width: 16, height: 16)
                .padding(.top, 24)
            
            VStack(alignment: .leading) {
                HStack {
                    TextField(
                        "Section title",
                        text: .constant(""),
                        prompt: Text("Section title")
                    )
                    .font(.title)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                TextView(
                    attributedText: Binding(value: .constant(Data())),
                    allowsEditingTextAttributes: true
                )
                
//                ForEach(section.charts) { chart in
//                    ChartView()
//                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 4)
        }
    }
}

//#Preview {
////    StatusSectionView(section: .init(name: "Summary"))
//    StatusSectionView()
//}
