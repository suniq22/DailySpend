import Foundation
struct Expense: Codable {
    let id: UUID
    let title: String
    let amount: Amount
    let date: Date
    let category: ExpenseCategory
    
    init(id: UUID = UUID(), title: String, amount: Amount, date: Date = Date(), category: ExpenseCategory) {
        self.id = id
        self.title = title
        self.amount = amount
        self.date = date
        self.category = category
    }
}
