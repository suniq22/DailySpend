import UIKit

final class SettingsViewController: UIViewController {
    private var currentCurrency: Currency = .usd
    private let settingsStore: SettingsStore
    private let contentView = SettingsView()
    private let cucurrencies = Currency.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.reuseID)
        bind()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.tableView.layoutIfNeeded()
        contentView.updateTableHeight(contentView.tableView.contentSize.height)
    }
    
    override func loadView() {
        view = contentView
    }
    
    private func bind() {
        settingsStore.onChange.append { [weak self] in
            guard let self else { return }
            self.currentCurrency = self.settingsStore.getCurrentCurrency()
            self.contentView.tableView.reloadData()
        }
    }
    
    init(settingsStore: SettingsStore) {
        self.settingsStore = settingsStore
        self.currentCurrency = settingsStore.getCurrentCurrency()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}
extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cucurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CurrencyCell.reuseID,
            for: indexPath
        ) as? CurrencyCell else {
            return UITableViewCell()
        }
        
        let currency = cucurrencies[indexPath.row]
        
        if currency == currentCurrency {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.configure(flag: currency.flag, name: currency.rawValue)
        
        return cell
    }
}
extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = cucurrencies[indexPath.row]
        settingsStore.setCurrentCurrency(currency)
    }
}
