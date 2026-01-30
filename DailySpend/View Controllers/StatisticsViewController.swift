import UIKit

final class StatisticsViewController: UIViewController {

    private let contentView = StatisticsView()
    private let expenseStore: ExpenseStore
    private let settingsStore: SettingsStore

    private var period: StatsPeriod = .week
    private var currency: Currency
    private var breakdown: [BreakdownItem] = []

    init(expenseStore: ExpenseStore, settingsStore: SettingsStore) {
        self.expenseStore = expenseStore
        self.settingsStore = settingsStore
        self.currency = settingsStore.getCurrentCurrency()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("") }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.tableView.dataSource = self
        contentView.tableView.register(
            CategoryBreakdownCell.self,
            forCellReuseIdentifier: CategoryBreakdownCell.reuseID
        )

        contentView.onPeriodChanged = { [weak self] index in
            self?.period = StatsPeriod.allCases[index]
            self?.reloadStats()
            self?.reloadCards()
        }

        contentView.onCurrencyChanged = { [weak self] index in
            self?.currency = Currency.allCases[index]
            self?.reloadStats()
            self?.reloadCards()
        }
        bind()
        reloadStats()
        reloadCards()
    }

    private func reloadStats() {
        let result = StatisticsCalculator.calculate(
            expenses: expenseStore.getExpenses(),
            period: period,
            currency: currency
        )

        breakdown = result.items

        contentView.tableView.reloadData()
        contentView.updateTableHeight()

        contentView.setSelectedCurrencyIndex(
            Currency.allCases.firstIndex(of: currency) ?? 0
        )
    }
    
    private func reloadCards() {
        let result = StatisticsCalculator.calculate(expenses: expenseStore.expenses, period: period, currency: currency)
        
        let summary = result.summary
        
        
        let total = MoneyFormatter.string(summary.total, currency: currency)
        let avg = MoneyFormatter.string(summary.avgPerDay, currency: currency)
 
        let topCategory = summary.topCategory
        guard let topCategory = topCategory else {
            contentView.configureCards(total: total , avg: avg, topCategory: .other)
            return
        }
        contentView.configureCards(total: total , avg: avg, topCategory: topCategory)
    }
    private func bind() {
        expenseStore.onChange.append { [weak self] in
            self?.reloadStats()
            self?.reloadCards()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.updateTableHeight()
    }
}

extension StatisticsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breakdown.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoryBreakdownCell.reuseID,
            for: indexPath
        ) as! CategoryBreakdownCell

        cell.configure(
            item: breakdown[indexPath.row],
            currency: currency
        )

        return cell
    }
}
