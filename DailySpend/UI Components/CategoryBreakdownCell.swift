import UIKit

final class CategoryBreakdownCell: UITableViewCell {

    static let reuseID = "CategoryBreakdownCell"
    
    private var currentPercent: CGFloat = 0
    private let iconLabel: UILabel = {
        $0.font = .systemFont(ofSize: 28)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let titleLabel: UILabel = {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .purple.withAlphaComponent(0.8)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let amountLabel: UILabel = {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .purple.withAlphaComponent(0.8)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let percentLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = .purple.withAlphaComponent(0.8)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let trackView: UIView = {
        $0.backgroundColor = .white.withAlphaComponent(0.2)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private let fillView: UIView = {
        $0.backgroundColor = .purple.withAlphaComponent(0.8)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private var fillWidthConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.addSubview(iconLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(percentLabel)
        contentView.addSubview(trackView)
        trackView.addSubview(fillView)
        
        fillWidthConstraint = fillView.widthAnchor.constraint(equalToConstant: 0)
        fillWidthConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            iconLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            iconLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            titleLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: iconLabel.centerYAnchor),

            percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            percentLabel.centerYAnchor.constraint(equalTo: iconLabel.centerYAnchor),

            amountLabel.trailingAnchor.constraint(equalTo: percentLabel.leadingAnchor, constant: -10),
            amountLabel.centerYAnchor.constraint(equalTo: iconLabel.centerYAnchor),

            trackView.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 8),
            trackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            trackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            trackView.heightAnchor.constraint(equalToConstant: 8),
            trackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            fillView.leadingAnchor.constraint(equalTo: trackView.leadingAnchor),
            fillView.topAnchor.constraint(equalTo: trackView.topAnchor),
            fillView.bottomAnchor.constraint(equalTo: trackView.bottomAnchor)
        
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        trackView.layer.cornerRadius = trackView.bounds.height / 2
        fillView.layer.cornerRadius = fillView.bounds.height / 2
    }

    required init?(coder: NSCoder) { fatalError("") }

    func configure(item: BreakdownItem, currency: Currency) {
        iconLabel.text = item.category.icon
        titleLabel.text = item.category.rawValue

        amountLabel.text = MoneyFormatter.string(item.amount, currency: currency)
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        percentLabel.text = "\(formatter.string(from: NSNumber(floatLiteral: item.percent)) ?? "0.00")"
        
        currentPercent = item.percent
        
        fillWidthConstraint?.isActive = false
        fillWidthConstraint = fillView.widthAnchor.constraint(
            equalTo: trackView.widthAnchor,
            multiplier: item.percent)
        fillWidthConstraint?.isActive = true
        
    }
    

}

