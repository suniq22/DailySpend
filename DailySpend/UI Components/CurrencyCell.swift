import UIKit
final class CurrencyCell: UITableViewCell {
    
    static let reuseID = "CurrencyCell"
    
    private let flagLabel: UILabel = {
        $0.font = .systemFont(ofSize: 40)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let nameLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .purple.withAlphaComponent(0.8)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupFlagLabel()
        setupNameLabel()
        setupGeneralUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private func setupFlagLabel() {
        contentView.addSubview(flagLabel)
        NSLayoutConstraint.activate([
            flagLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            flagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5)
        ])
    }
    
    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: flagLabel.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: flagLabel.trailingAnchor, constant: 3)
        ])
    }

    private func setupGeneralUI() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.backgroundColor = .white.withAlphaComponent(0.65)
        contentView.layer.cornerRadius = 14
        contentView.clipsToBounds = true
        
    }
    
    func configure(flag: String, name: String) {
        flagLabel.text = flag
        nameLabel.text = name
    }
}
