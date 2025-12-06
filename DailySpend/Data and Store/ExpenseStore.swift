import Foundation

class ExpenseStore {
    private var expenses: [Expense] = []
    private let key: String = "expenses"
    var change: (() -> Void)?
    func add(_ expense: Expense) {
        expenses.append(expense)
        save()
        change?()
    }
    func todayTotal() -> Decimal {
        let todayExpenses = expenses.filter { Calendar.current.isDateInToday($0.date)}
        let total = todayExpenses.reduce( Decimal.zero) {$0 + $1.amount}
        return total
    }
    func save() {
        UserDefaults.standard.set(try? JSONEncoder().encode(expenses), forKey: key)
    }
    func load() {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            expenses = []
            change?()
            return
        }
        expenses = (try? JSONDecoder().decode([Expense].self, from: data)) ?? []
        change?()
    }
}
