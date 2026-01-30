import UIKit

final class HistoryViewController: UIViewController {
    private let contentView = HistoryView()
    private let expenseStore: ExpenseStore
    private var sections: [MonthSection] = []
    
    private let monthFormatter: DateFormatter = {
        $0.dateFormat = "LLLL yyyy"
        return $0
    }(DateFormatter())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSections()
        setupTable()
        bind()
    }
    
    override func loadView() {
     view = contentView
    }
    
    init(expenseStore: ExpenseStore) {
        self.expenseStore = expenseStore
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private func bind() {
        expenseStore.onChange.append { [weak self] in
            self?.fetchSections()
            self?.contentView.tableView.reloadData()
        }
    }
    
    private func setupTable() {
        contentView.tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.reuseID)
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    
    private func fetchSections() {
        let expenses = expenseStore.getExpenses()
        let now = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month], from: now)
        
        let startOfThisMonth = calendar.date(from: components)!
        
        let startOfWindow = calendar.date(byAdding: .month, value: -11, to: startOfThisMonth)!
        
        let expensesInWindow = expenses.filter {$0.date >= startOfWindow}
        
        let groupedByMonth = Dictionary(grouping: expensesInWindow) { expense in
            calendar.dateComponents([.year, .month], from: expense.date)
        }
        var sections = groupedByMonth.map {
            MonthSection(monthStart: calendar.date(from: $0.key)! , items: $0.value.reversed())
        }
        sections.sort { $0.monthStart > $1.monthStart }
        self.sections = sections
    }
}

extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expense = sections[indexPath.section].items[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HistoryCell.reuseID,
            for: indexPath
        ) as? HistoryCell else {
            return UITableViewCell()
        }
        cell.configure(expense: expense)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
}
extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white.withAlphaComponent(0.7)
        label.text = monthFormatter.string(from: sections[section].monthStart)

        let container = UIView()
        container.backgroundColor = .clear

        label.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8)
        ])

        return container
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         40
     }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completionHandler in
            guard let self else { return }
            let expense = self.sections[indexPath.section].items[indexPath.row]
            self.expenseStore.delete(id: expense.id)
            
            self.fetchSections()
            self.contentView.tableView.reloadData()
            
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
