import SwiftUI

struct CustomFieldModal: View {
    @Environment(\.modelContext) private var context
    @State private var showDescription: Bool = false
    @Bindable var field: CustomField
    
    init(_ field: CustomField) {
        self.field = field
    }
    
    var body: some View {
        Grid(
            alignment: .topLeading,
            horizontalSpacing: 24,
            verticalSpacing: 24
        ) {
//            GridRow {
//                LabeledInput("Field type") {
//                    TextField(
//                        "Title",
//                        text: Binding(value: $field.name),
//                        prompt: Text("Priority, Stage, Status…")
//                    )
//                    .textFieldStyle(.roundedBorder)
//                }
//                .gridCellColumns(2)
//                
//                LabeledInput("Field type") {
//                    Picker(selection: $field.format) {
//                        ForEach(CustomField.FieldType.allCases, id: \.self) { type in
//                            Text(type.rawValue)
//                        }
//                    } label: {
//                        
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                .gridCellColumns(1)
//            }
//            
//            if showDescription || field.notes != nil {
//                GridRow {
//                    LabeledInput("Description") {
//                        TextField(
//                            "Description",
//                            text: Binding(value: $field.notes)
//                        )
//                        .textFieldStyle(.roundedBorder)
//                    }
//                }
//            } else {
//                Button("Add description", systemImage: "plus") {
//                    showDescription.toggle()
//                }
//            }
//            
//            if field.format == .singleSelect || field.format == .multiSelect {
//                ForEach(field.enumOptions ?? []) { option in
//                    Text(option.name)
//                }
//            }
        }
        .navigationTitle("Add field")
//        .onChange(of: field.format) { oldValue, newValue in
//            if newValue == .singleSelect || newValue == .multiSelect {
//                let firstBlank = EnumOption(color: .green, name: "")
//                let secondBlank = EnumOption(color: .red, name: "", order: 1)
//                context.insert(firstBlank)
//                context.insert(secondBlank)
//                field.enumOptions?.append(contentsOf: [firstBlank, secondBlank])
//            } else {
//                if let enumOptions = field.enumOptions, enumOptions.count > 0 {
//                    for option in enumOptions {
//                        context.delete(option)
//                    }
//                }
//            }
//        }
//        .onAppear {
//            if field.format == .singleSelect || field.format == .multiSelect {
//                let firstBlank = EnumOption(color: .green, name: "")
//                let secondBlank = EnumOption(color: .red, name: "", order: 1)
//                context.insert(firstBlank)
//                context.insert(secondBlank)
//                field.enumOptions?.append(contentsOf: [firstBlank, secondBlank])
//            } else {
//                if let enumOptions = field.enumOptions, enumOptions.count > 0 {
//                    for option in enumOptions {
//                        context.delete(option)
//                    }
//                }
//            }
//        }
    }
}

#Preview {
    NavigationStack {
//        CustomFieldModal(.init())
    }
    .modelContainer(for: CustomField.self, inMemory: true)
}
