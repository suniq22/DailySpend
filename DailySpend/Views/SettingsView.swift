import UIKit

final class SettingsView: GradientView {
    private let mainLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        $0.textColor = .white.withAlphaComponent(0.7)
        $0.text = "Settings"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let settingsImageView: UIImageView = {
        $0.image = UIImage(named: "Settings")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let currencyLabel: UILabel = {
        $0.font = .systemFont(ofSize: 22, weight: .regular)
        $0.textColor = .white.withAlphaComponent(0.7)
        $0.text = "Choose Currency"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let tableContainerView: UIView = {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 18
        $0.backgroundColor = .white.withAlphaComponent(0.35)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    var tableView: UITableView = {
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.separatorColor = .none
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    private var tableHeightConstraint: NSLayoutConstraint?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMainLabel()
        setupSettingImageView()
        setupCurrencyLabel()
        setupTableContainerView()
        setupTableView()
        
    }
    
    private func setupMainLabel() {
        addSubview(mainLabel)
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -25),
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupSettingImageView() {
        addSubview(settingsImageView)
        NSLayoutConstraint.activate([
            settingsImageView.centerYAnchor.constraint(equalTo: mainLabel.centerYAnchor),
            settingsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            settingsImageView.heightAnchor.constraint(equalToConstant: 100),
            settingsImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupCurrencyLabel() {
        addSubview(currencyLabel)
        NSLayoutConstraint.activate([
            currencyLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            currencyLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupTableContainerView() {
        addSubview(tableContainerView)
        NSLayoutConstraint.activate([
            tableContainerView.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 12),
            tableContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            tableContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ])
    }
    
    private func setupTableView() {

        tableContainerView.addSubview(tableView)
        
        tableHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 1)
        tableHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tableContainerView.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: tableContainerView.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: tableContainerView.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: tableContainerView.bottomAnchor, constant: -10)
        ])
    }
    
    func updateTableHeight(_ height: CGFloat) {
        tableHeightConstraint?.constant = height
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }
}
