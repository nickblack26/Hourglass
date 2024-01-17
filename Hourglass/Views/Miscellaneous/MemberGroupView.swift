import SwiftUI

//struct MemberGroupView: View {
//    var members: [Member]
//    
//    init(_ members: [Member]) {
//        self.members = members
//    }
//    
//    let totalColumns = 4
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            let count = members.count > 4 ? 4 : members.count
//            ForEach(0..<count, id: \.self) { _ in
//                AvatarView(
//                    image: tempUrl,
//                    fallback: "Nick Black",
//                    size: .small
//                )
//            }
//        
//            let total = totalColumns - members.count
//            if total > 0 {
//                ForEach(0..<total, id: \.self) { _ in
//                    Button {} label: {
//                        Image(systemName: "person")
//                            .imageScale(.small)
//                    }
//                    .buttonStyle(.bordered)
//                    .tint(.clear)
//                    .foregroundStyle(.secondary)
//                    .overlay(
//                        Circle()
//                            .strokeBorder(
//                                .secondary,
//                                style:
//                                    StrokeStyle(
//                                        lineWidth: 1,
//                                        dash: [4]
//                                    )
//                            )
//                    )
//                    .clipShape(Circle())
//                }
//            } else if total < 0 {
//                Button("\(members.count - 4)") {}
//                .buttonStyle(.bordered)
//                .tint(.secondary)
//                .clipShape(Circle())
//            }
//        }
//    }
//}

//#Preview {
//    HStack {
//        Spacer()
//        MemberGroupView([.preview, .preview, .preview, .preview, .preview])
//    }
//    .frame(maxWidth: .infinity, alignment: .trailing)
//}
