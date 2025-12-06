import UIKit

final class CategoryBreakdownCell: UITableViewCell {

    static let reuseID = "CategoryBreakdownCell"

    private let iconLabel: UILabel = {
        $0.font = .systemFont(ofSize: 28)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let titleLabel: UILabel = {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .white.withAlphaComponent(0.85)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let amountLabel: UILabel = {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .white.withAlphaComponent(0.85)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let percentLabel: UILabel = {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .white.withAlphaComponent(0.6)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let trackView: UIView = {
        $0.backgroundColor = .white.withAlphaComponent(0.2)
        $0.layer.cornerRadius = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private let fillView: UIView = {
        $0.backgroundColor = .white.withAlphaComponent(0.7)
        $0.layer.cornerRadius = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private var fillWidthConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

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

    required init?(coder: NSCoder) { fatalError("") }

    func configure(item: BreakdownItem, currency: Currency) {
        iconLabel.text = item.category.icon
        titleLabel.text = item.category.rawValue

        amountLabel.text = String(format: "%.2f %@", item.amount, currency.symbol)
        percentLabel.text = "\(Int(item.percent * 100))%"

        contentView.layoutIfNeeded()
        fillWidthConstraint?.constant = trackView.bounds.width * item.percent
    }
}

