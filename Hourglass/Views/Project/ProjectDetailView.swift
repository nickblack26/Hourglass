import SwiftUI
import SwiftData

fileprivate enum Tab: String, CaseIterable {
    case newList = "New List"
    case templates = "Templates"
}

struct ProjectDetailView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \Client.name) private var clients: [Client]
    var isNew: Bool = false
    
    @State private var project: Project = .init(name: "")
    
    init(_ project: Project) {
        self._project = State(initialValue: project)
    }
    
    init() {
        self.isNew = true
    }
    
    var body: some View {
        Form {
            Section {
                Image(project.icon.icon)
                    .resizable()
                    .frame(width: 64, height: 64)
                    .padding()
                    .background(
                        project.color.color,
                        in: .rect(cornerRadius: 8)
                    )
                    .frame(
                        maxWidth: .infinity,
                        alignment: .center
                    )
                
                TextField("Project name", text: $project.name)
                    .font(.title3)
                    .padding(8)
                    .background(Color(uiColor: .systemGray4))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Picker(
                    "Client",
                    selection: Binding(get: {
                        if let client = project.client {
                            return client
                        } else {
                            if !clients.isEmpty {
                                return clients[0]
                            }
                        }
                        return nil
                    }, set: { newValue in
                        project.client = newValue
                    })
                ) {
                    Text("Choose a client")
                        .tag(Optional<Client?>(nil))
                    
                    ForEach(clients) { client in
                        Text(client.name)
                            .tag(Optional(client))
                    }
                }
                
                DatePicker(
                    "Due date",
                    selection: Binding(value: $project.endDate),
                    displayedComponents: .date
                )
                
                Picker(
                    "Default view",
                    systemImage: project.defaultTab.image,
                    selection: $project.defaultTab
                ) {
                    ForEach(Project.Tab.allCases, id: \.self) { project in
                        Text(project.rawValue)
                            .tag(project)
                    }
                }
            }
            .listRowSeparator(.hidden)
            
            Section("Services") {
                if let services = project.services, !services.isEmpty {
                    ForEach(services, id: \.name) { lineItem in
                        LineItemView(lineItem: lineItem)
                            .contextMenu {
                                Button("Delete", systemImage: "trash", role: .destructive) {
                                    withAnimation(.snappy) {
                                        context.delete(lineItem)
                                    }
                                }
                            }
                    }
                    .onDelete(perform: delete)
                }
                
                Button("Add another service", systemImage: "plus.circle.fill") {
                    withAnimation(.snappy) {
                        createLineItem()
                    }
                }
            }
            
            Section("Billing Schedule") {
                Toggle(
                    "Deposit",
                    systemImage: "dollarsign",
                    isOn: $project.depositRequired
                )
                
                Picker(
                    "Invoice schedule",
                    selection: $project.invoiceSchedule
                ) {
                    ForEach(Project.InvoiceSchedule.allCases, id: \.self) {
                        Text($0.rawValue)
                            .tag($0)
                    }
                }
                
                if let invoices = project.invoices, !invoices.isEmpty {
                    ForEach(invoices) { invoice in
                        InvoiceListItemView(
                            schedule: project.invoiceSchedule,
                            invoice: invoice
                        )
                        .contextMenu {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                withAnimation(.snappy) {
                                    context.delete(invoice)
                                }
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
                
                if project.invoiceSchedule == .custom {
                    Button("Add another invoice", systemImage: "plus.circle.fill") {
                        withAnimation(.snappy) {
                            createInvoice()
                        }
                    }
                }
            }
            
            Section {
                Picker(
                    "Color",
                    selection: $project.color
                ) {
                    HStack {
                        ForEach(ThemeColor.allCases, id: \.self) { color in
                            Circle()
                                .fill(color.color)
                                .tag(color)
                        }
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            
            Section {
                Picker(
                    "Icon",
                    selection: $project.icon
                ) {
                    HStack {
                        ForEach(
                            Project.Icon.allCases,
                            id: \.self
                        ) { icon in
                            Image(icon.icon)
                                .resizable()
                                .scaledToFit()
                                .padding(8)
                                .background(
                                    Color(
                                        uiColor: .systemGray6
                                    ),
                                    in: Circle()
                                )
                                .tag(icon)
                        }
                        
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
        }
        .onAppear(perform: {
            if isNew {
                context.insert(project)
                createInvoice()
                createLineItem()
            }
        })
        .navigationTitle(
            project.name.isEmpty ? "New project" : project.name
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    if isNew {
                        context.delete(project)
                    }
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("Done") {
                    withAnimation(.snappy) {
                        if isNew {
                            createProject()
                        }
                        dismiss()
                    }
                }
                .disabled(project.name.isEmpty)
            }
        }
        .onSubmit {
            withAnimation(.snappy) {
                if isNew {
                    createProject()
                }
                dismiss()
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        project.services?.remove(atOffsets: offsets)
    }
    
    private func createProject() {
        withAnimation(.snappy) {
            context.insert(project)
        }
    }
    
    private func createLineItem () {
        withAnimation(.snappy) {
            let lineItem = LineItem(name: "")
            project.services?.append(lineItem)
        }
    }
    
    private func createInvoice () {
        withAnimation(.snappy) {
            let invoice = Invoice(name: "")
            project.invoices?.append(invoice)
        }
    }
}

#Preview {
    VStack {
        Text("")
    }
    .sheet(isPresented: .constant(true), content: {
        NavigationStack {
            ProjectDetailView()
        }
    })
}
