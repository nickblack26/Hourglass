import SwiftUI
import SwiftData
import Charts

struct ProjectOverviewTab: View {
    static var milestoneType: String = aTask.TaskType.milestone.rawValue
    
    @Query(
        filter: #Predicate<aTask> {
            !$0.isCompleted
        }
    )
    private var milestones: [aTask]
    
    @Query private var goals: [Goal]
    @Query private var invoices: [Transaction]
    @Query private var transactions: [Transaction]
    @Query private var timesheets: [Timesheet]
    
    var project: Project
    
    init(_ project: Project) {
        let projectId = project.persistentModelID
        self.project = project
        self._invoices = Query(
            filter: #Predicate<Transaction> {
                $0.project != nil && $0.invoice != nil && $0.project?.persistentModelID == projectId
            }
        )
        self._transactions = Query(
            filter: #Predicate<Transaction> {
                $0.project != nil && $0.invoice == nil && $0.project?.persistentModelID == projectId
            }
        )
    }
    
    var body: some View {
        Grid(alignment: .topLeading) {
            GridRow(alignment: .top) {
                List {
                    Section("Project description") {
                        TextView(
                            attributedText: .constant(
                                NSAttributedString(string: "")
                            )
                        )
                        .frame(minHeight: 100)
                    }
                    .listRowSeparator(.hidden)
                    
                    Section("Connected goals") {
                        Card {
                            HStack {
                                Image("shooting_target")
                                    .resizable()
                                    .frame(
                                        width: 128,
                                        height: 128
                                    )
                                
                                VStack(alignment: .leading) {
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
                    }
                    .listRowSeparator(.hidden)
                    
                    Section("Connected portfolios") {
                        Card {
                            HStack {
                                Image("organization_structure")
                                VStack(alignment: .leading) {
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
                    }
                    .listRowSeparator(.hidden)
                    
                    Section("Invoices") {
                        Card {
                            Table(invoices) {
                                TableColumn("Invoice") { transaction in
                                    if let invoice = transaction.invoice {
                                        Text("\(invoice.number)")
                                    }
                                }
                                
                                TableColumn("Created At") { transaction in
                                    if let invoice = transaction.invoice {
                                        Text(invoice.createdAt.formatted(date: .abbreviated, time: .omitted))
                                    }
                                }
                                
                                TableColumn("Due") { transaction in
                                    if let invoice = transaction.invoice, let dueDate = invoice.dueDate {
                                        Text(dueDate.formatted(date: .abbreviated, time: .omitted))
                                    }
                                }
                                
                                TableColumn("Amount") { transaction in
                                    if let invoice = transaction.invoice {
                                        Text(invoice.number, format: .currency(code: "USD"))
                                    }
                                }
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                    
                    Section("Transactions") {
                        Chart {
                            ForEach(timesheets) {
                                BarMark(
                                    x: .value(
                                        "Day",
                                        $0.start,
                                        unit: .day
                                    ),
                                    y: .value(
                                        "Hour",
                                        $0.start,
                                        unit: .hour
                                    )
                                )
                            }
                            
                            RuleMark(y: .value("", 28))
                        }
                        
                        Card {
                            Table(transactions) {
                                TableColumn("Description") { transaction in
                                    Text(transaction.purpose)
                                }
                                
                                TableColumn("Merchant") { transaction in
                                    Text(transaction.merchant?.name ?? "")
                                }
                                
                                TableColumn("Created At") { transaction in
                                    Text(transaction.createdAt.formatted(date: .abbreviated, time: .omitted))
                                }
                                
                                TableColumn("Due") { transaction in
                                    Text(transaction.date.formatted(date: .abbreviated, time: .omitted))
                                }
                                
                                TableColumn("Amount") { transaction in
                                    Text(transaction.total, format: .currency(code: "USD"))
                                }
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                    
                    Section("Milestones") {
                        ForEach(milestones) { milestone in
                            Text(milestone.name)
                            Divider()
                        }
                        .listStyle(.plain)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .padding()
                .gridCellColumns(2)
                
                List {
                    
                }
                .gridCellColumns(1)
                .listStyle(.plain)
                .padding()
                .scrollContentBackground(.hidden)
                .background(
                    Color(
                        uiColor: .systemGray6
                    )
                )
            }
        }
    }
}

#Preview {
    ProjectOverviewTab(.init(name: ""))
}
