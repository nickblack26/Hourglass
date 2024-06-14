import SwiftUI

struct LineItemView: View {
    @Bindable var lineItem: LineItem
    
    var body: some View {
        Grid {
            GridRow {
                TextField("Name", text: $lineItem.name)
                    .textFieldStyle(.roundedBorder)
                    .gridCellColumns(2)
            }
            
            GridRow {
                CurrencyField(amount: Binding(value: $lineItem.rate))
                
                Picker(
                    "Pricing Structure",
                    selection: $lineItem.pricingStructure
                ) {
                    ForEach(LineItem.Structure.allCases, id: \.self) { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                }
            }
            
            if lineItem.pricingStructure != .flatFee {
                GridRow {
                    TextField(
                        "Hours",
                        value: Binding(value: $lineItem.quantity),
                        format: .number
                    )
                    .gridCellColumns(2)
                }
            }
            
            GridRow {
                TextField(
                    "Notes",
                    text: Binding(value: $lineItem.notes),
                    prompt: Text("Enter description here..."),
                    axis: .vertical
                )
                .lineLimit(4, reservesSpace: true)
                .gridCellColumns(2)
            }
            
            GridRow {
                LabeledContent("Service total") {
                    FormattedCurrencyField(lineItem.amount)
                }
                .gridCellColumns(2)
            }
        }
    }
}

#Preview {
    LineItemView(lineItem: .init(name: ""))
}
