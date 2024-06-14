import SwiftUI
import SwiftData

struct MerchantField: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Merchant.name) private var merchants: [Merchant]
    
    var body: some View {
        HStack {
            ForEach(merchants) { merchant in
                MerchantView(merchant: merchant)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(.bar, in: .rect(cornerRadius: 12))
        .onAppear(perform: {
            if merchants.isEmpty {
                let merchant = Merchant(name: "")
                context.insert(merchant)
            }
        })
    }
}

#Preview {
    MerchantField()
}

fileprivate struct MerchantView: View {
    @Bindable var merchant: Merchant
    @FocusState private var isFocused: Bool
    var body: some View {
        TextField("Name", text: $merchant.name)
            .focused($isFocused)
            .padding(8)
    }
}


//fileprivate str

