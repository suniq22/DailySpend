import UIKit

final class AddExpenseViewController: UIViewController {
    
    private let expenseStore: ExpenseStore
    private let contentView = AddExpenseView()
    private let settingsStore: SettingsStore
    private var currentCurrency: Currency = .usd
    
    init(expenseStore: ExpenseStore, settingsStore: SettingsStore) {
        self.expenseStore = expenseStore
        self.settingsStore = settingsStore
        self.currentCurrency = settingsStore.getCurrentCurrency()
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .pageSheet
    }
    
    required init?(coder: NSCoder) { fatalError("") }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        contentView.render(categories: ExpenseCategory.allCases, selectedCategory: .food, currencyString: currentCurrency.symbol)
        contentView.renderCurrencyString(currentCurrency.rawValue)
        setupKeyboardHandling()
        addTapRecognizer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.layoutGradient()
    }
    
    private func bind() {
        
        contentView.onClose = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        contentView.onSave = { [weak self] input in
            self?.save(input: input)
        }
        
        settingsStore.onChange.append { [weak self] in
            let currencyString = self?.settingsStore.getCurrentCurrency().symbol ?? ""
            self?.contentView.renderCurrencyString(currencyString)
        }
    }
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let kbFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let height = kbFrame.height
            contentView.scrollOffset(height: height)
        }
    }
    
    @objc private func keyboardWillHide() {
        contentView.scrollView.contentOffset = .zero
    }
    
    private func save(input: AddExpenseInput) {
        do {
            let expense = try makeExpense(from: input)
            expenseStore.add(expense)
            dismiss(animated: true)
        } catch {
            let message = (error as? LocalizedError)?.errorDescription ?? "Unknown error"
            showError(message: message)
        }
    }
    
    @objc private func tapGestureRecognized() {
        view.endEditing(true)
    }
    
    private func addTapRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func makeExpense(from input: AddExpenseInput) throws -> Expense {
        let title = input.title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty else { throw AddExpenseValidationError.emptyTitle }

        let value = try AmountParser.parse(input.value)

        return Expense(title: title, amount: Amount(value: value, currency: settingsStore.getCurrentCurrency()), date: Date(), category: input.category)
    }

    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
