import SwiftUI
import SwiftData
import Charts

struct ProjectOverviewTab: View {
    static var milestoneType: String = aTask.TaskType.milestone.rawValue
	
	@Environment(HourglassManager.self) private var hourglass
    
    @Query(
        filter: #Predicate<aTask> {
            !$0.isCompleted
        }
    )
    private var milestones: [aTask]
    
    @Query private var goals: [Goal]
    @Query private var invoices: [Invoice]
    @Query private var transactions: [Transaction]
    @Query private var lineItems: [LineItem]
    @Query private var timesheets: [Timesheet]
    var project: Project
    
    init(_ project: Project) {
        let projectId = project.persistentModelID
        self.project = project
        self._invoices = Query(
            filter: #Predicate<Invoice> {
                $0.project != nil && $0.project?.persistentModelID == projectId
            }
        )
        self._lineItems = Query(
            filter: #Predicate<LineItem> {
                $0.project != nil && $0.project?.persistentModelID == projectId
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
							HStack {
								if invoices.isEmpty {
									Image("key_resources")
										.resizable()
										.frame(
											width: 128,
											height: 128
										)
									VStack(alignment: .leading,
										   content: {
										Text("Don't let your work float in the void: tether it to payment with a clear, crisp invoice.")
										
										Button(
											"Create invoice",
											systemImage: "list.clipboard"
										) {
											hourglass.selectedInvoice = .init(
												name: "",
												project: project
											)
										}
									})
								} else {
									Table(invoices) {
										TableColumn("Invoice") { invoice in
                                            Text("\(invoice.number)")
										}
										
										TableColumn("Created At") { invoice in
                                            Text(invoice.createdAt.formatted(date: .abbreviated, time: .omitted))
										}
										
										TableColumn("Due") { invoice in
											if let dueDate = invoice.dueDate {
												Text(dueDate.formatted(date: .abbreviated, time: .omitted))
											}
										}
										
										TableColumn("Amount") { invoice in
                                            if let lines = invoice.lines {
                                                let total = lines.reduce(0) { partialResult, lineItem in
                                                    return partialResult + lineItem.amount
                                                }
												Text(total, format: .currency(code: "USD"))
											}
										}
									}
								}
							}
                        }
                    }
                    .listRowSeparator(.hidden)
                    
                    Section("Transactions") {
//                        Chart {
//                            ForEach(timesheets) {
//                                BarMark(
//                                    x: .value(
//                                        "Day",
//                                        $0.start,
//                                        unit: .day
//                                    ),
//                                    y: .value(
//                                        "Hour",
//                                        $0.start,
//                                        unit: .hour
//                                    )
//                                )
//                            }
//                            
//                            RuleMark(y: .value("", 28))
//                        }
                        
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
                                
//                                TableColumn("Amount") { transaction in
//                                    Text(transaction.total, format: .currency(code: "USD"))
//                                }
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
