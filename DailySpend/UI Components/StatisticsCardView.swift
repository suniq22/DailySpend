import UIKit

final class StatisticsCardView: UIView {

    enum Style { case green, blue, orange }

    private let iconView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white.withAlphaComponent(0.95)
        return  $0
    }(UIImageView())

    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .white.withAlphaComponent(0.85)
        $0.numberOfLines = 2
        return  $0
    }(UILabel())

    private let valueLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .white.withAlphaComponent(0.9)
        $0.numberOfLines = 2
        return $0
    }(UILabel())

    init(style: Style) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 18
        clipsToBounds = true
        backgroundColor = color(for: style)
        setupConstrains()
    }
    private func setupConstrains() {
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(valueLabel)

        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            iconView.widthAnchor.constraint(equalToConstant: 34),
            iconView.heightAnchor.constraint(equalToConstant: 34),

            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("") }

    func configure(title: String, value: String, icon: String) {
        titleLabel.text = title
        valueLabel.text = value
        iconView.image = UIImage(systemName: icon)
    }

    private func color(for style: Style) -> UIColor {
        switch style {
        case .green: return UIColor.systemGreen.withAlphaComponent(0.75)
        case .blue: return UIColor.systemBlue.withAlphaComponent(0.75)
        case .orange: return UIColor.systemOrange.withAlphaComponent(0.75)
        }
    }
}
