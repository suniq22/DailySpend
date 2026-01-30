import UIKit

final class HistoryView: GradientView {
    
    private let label: UILabel = {
        $0.text = "History"
        $0.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        $0.textColor = .white.withAlphaComponent(0.7)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let tableView: UITableView = {
        $0.backgroundColor = .clear
        $0.separatorColor = .none
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    private let imageView: UIImageView = {
        $0.image = UIImage(named: "History")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
        setupTableView()
        setupImageView()
    }
    
    private func setupLabel() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -25),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupTableView() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupImageView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            imageView.widthAnchor.constraint(equalToConstant: 90),
            imageView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}
	
