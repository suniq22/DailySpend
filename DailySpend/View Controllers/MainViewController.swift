import UIKit

final class MainViewController: UIViewController {
    private let expenseStore: ExpenseStore
    private let contentView = MainView()
    private let settingsStore: SettingsStore
    private var currentCurrency: Currency = .usd
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentCurrency = settingsStore.getCurrentCurrency()
        bind()
        updateTotalExpense()
        loadLastExpense()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.layoutAddExpenseButton()
        contentView.layoutlastExpenseImageContainer()
        
    }
    
    override func loadView() {
        view = contentView
    }
    
    private func bind() {
        contentView.addExpenseButtonAction = addExpense
        expenseStore.onChange.append { [weak self] in
            self?.updateTotalExpense()
            self?.loadLastExpense()
        }
        settingsStore.onChange.append { [weak self] in
            self?.currentCurrency = self?.settingsStore.getCurrentCurrency() ?? .byn
            self?.updateTotalExpense()
            self?.loadLastExpense()
        }
    }
    
    private func updateTotalExpense() {
        let amount = expenseStore.todayTotal()
        
        let amountString = MoneyFormatter.string(amount, currency: currentCurrency)
        contentView.render(totalAmount: amountString)
    }
    
    private func loadLastExpense() {
        let expense = expenseStore.getLastExpense()
        let title = expense.title
        let imageName = expense.category.rawValue
        let amount = MoneyFormatter.string(expense.amount.value, currency: expense.amount.currency)
        contentView.renderLastExpense(title: title, amount: amount, imageName: imageName)
    }
    
    private func addExpense() {
        let vc = AddExpenseViewController(expenseStore: expenseStore, settingsStore: settingsStore)
        vc.sheetPresentationController?.prefersGrabberVisible = true
        vc.sheetPresentationController?.preferredCornerRadius = 28
        present(vc, animated: true)
    }
    
    init(expenseStore: ExpenseStore, settingsStore: SettingsStore) {
        self.expenseStore = expenseStore
        self.settingsStore = settingsStore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}

