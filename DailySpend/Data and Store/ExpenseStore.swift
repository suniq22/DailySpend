import Foundation

final class ExpenseStore {
    private(set) var expenses: [Expense] = []
    private let key: String = "expenses"
    private let settingsStore: SettingsStore
    var onChange: [() -> Void] = []
    
    init(settingsStore: SettingsStore) {
        self.settingsStore = settingsStore
    }
    
    func getExpenses() -> [Expense] { expenses }
    
    func add(_ expense: Expense) {
        expenses.append(expense)
        save()
        notify()
    }
    
    func delete(id: UUID) {
        expenses.removeAll { $0.id == id }
        save()
        notify()
    }
    
    private func notify() {
        onChange.forEach { $0() }
    }
    
    func todayTotal() -> Double {
        var todayExpenses = expenses.filter { Calendar.current.isDateInToday($0.date)}
        todayExpenses = todayExpenses.filter { $0.amount.currency == settingsStore.getCurrentCurrency() }
        let total = todayExpenses.reduce( Double.zero) {$0 + $1.amount.value}
        return total
    }
    
    func save() {
        UserDefaults.standard.set(try? JSONEncoder().encode(expenses), forKey: key)
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: "expenses"),
           let decoded = try? JSONDecoder().decode([Expense].self, from: data) {
            expenses = decoded
        }
        notify()
    }
    
    func getLastExpense() -> Expense {
        if let last = expenses.last {
            return last
        } else {
            return Expense(title: "There are no expenses yet", amount: Amount(value: 0.00, currency: settingsStore.getCurrentCurrency()), date: Date(), category: ExpenseCategory.other)
        }
    }
}
