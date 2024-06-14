import Foundation
import SwiftData

@Model
final class Invoice {
    var id: UUID
    var date: String?
    var number: String?
    var createdDate: String?
    var paidDate: String?
    var sentDate: String?
    var currency: String?
    var client: Client?
    var project: Project?
    var projects: [Project]?
    var status: Int?
    var paymentTermsType: Int?
    var items: [Item]?
    var attachment: Attachment?
    var total: Int?
    var expensesTotal: Int?
    var totalNoExpenses: Int?
    var taxDefinition: TaxDefinition?
    var options: Options?
    var payments: [Payment]?
    var overdue: Bool?
    var openAmount: Int?
    var paidAmount: Int?
    var history: [History]?
    var dueDate: String?
    var amountDue: Int?
    var paymeUrl: String?

    init(
        date: String?,
        number: String?,
        createdDate: String?,
        paidDate: String?,
        sentDate: String?,
        currency: String?,
        client: Client?,
        project: Project?,
        projects: [Project]?,
        status: Int?,
        paymentTermsType: Int?,
        items: [Item]?,
        attachment: Attachment?,
        total: Int?,
        expensesTotal: Int?,
        totalNoExpenses: Int?,
        taxDefinition: TaxDefinition?,
        options: Options?,
        payments: [Payment]?,
        overdue: Bool?,
        openAmount: Int?,
        paidAmount: Int?,
        history: [History]?,
        dueDate: String?,
        amountDue: Int?,
        paymeUrl: String?
    ) {
        self.id = .init()
        self.date = date
        self.number = number
        self.createdDate = createdDate
        self.paidDate = paidDate
        self.sentDate = sentDate
        self.currency = currency
        self.client = client
        self.project = project
        self.projects = projects
        self.status = status
        self.paymentTermsType = paymentTermsType
        self.items = items
        self.attachment = attachment
        self.total = total
        self.expensesTotal = expensesTotal
        self.totalNoExpenses = totalNoExpenses
        self.taxDefinition = taxDefinition
        self.options = options
        self.payments = payments
        self.overdue = overdue
        self.openAmount = openAmount
        self.paidAmount = paidAmount
        self.history = history
        self.dueDate = dueDate
        self.amountDue = amountDue
        self.paymeUrl = paymeUrl
    }
}

extension Invoice {
    enum DueDate: Codable {
        case uponReceipt, uponCompletion
    }
    
    enum Status: String, CaseIterable, Codable {
        case draft
        case open
        case paid
        case void
    }
}
