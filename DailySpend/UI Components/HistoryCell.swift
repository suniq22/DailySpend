
import UIKit

final class HistoryCell: UITableViewCell {
    static let reuseID = "HistoryCell"
    
    private let titleLabel: UILabel = {
        $0.textColor = .purple.withAlphaComponent(0.8)
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.numberOfLines = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let dateLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .purple.withAlphaComponent(0.8)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let amountLabel: UILabel = {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .purple.withAlphaComponent(0.8)
        $0.textAlignment = .right
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let categoryImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupGeneralUI()
        amountLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        amountLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private func setupConstraints() {
        contentView.addSubview(categoryImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            categoryImageView.heightAnchor.constraint(equalToConstant: 55),
            categoryImageView.widthAnchor.constraint(equalToConstant: 55),
            categoryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: categoryImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: categoryImageView.topAnchor),
            
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            amountLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor),
            dateLabel.leadingAnchor.constraint(lessThanOrEqualTo: amountLabel.leadingAnchor),
            
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.leadingAnchor, constant: -3)
        ])
    }
    
    func configure(expense: Expense) {
        titleLabel.text = expense.title
        categoryImageView.image = UIImage(named: expense.category.rawValue)
        let amount = MoneyFormatter.string(expense.amount.value, currency: expense.amount.currency)
        amountLabel.text = amount
        dateLabel.text = expense.date.formatted()
    }
    
    private func setupGeneralUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .white.withAlphaComponent(0.35)
        contentView.layer.cornerRadius = 14
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}
