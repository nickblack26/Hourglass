import Foundation
import SwiftData

@Model
final class Merchant {
    var name: String = ""
    
    @Relationship(deleteRule: .nullify, inverse: \Transaction.merchant)
    var transactions: [Transaction] = []
    
    init(name: String) {
        self.name = name
    }
}
