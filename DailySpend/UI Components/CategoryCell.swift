import UIKit
final class CategoryCell: UICollectionViewCell {
    static let reuseID = "CategoryCell"
    private let label: UILabel = {
        $0.font = .boldSystemFont(ofSize: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        applyStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(category: ExpenseCategory) {
        label.text = category.displayTitle
    }
    
    override var isSelected: Bool {
        didSet {
            applyStyle()
        }
    }
    
    private func applyStyle() {
        if isSelected {
            contentView.backgroundColor = .purple
            label.textColor = .white
        } else {
            contentView.backgroundColor = .white
            label.textColor = .purple
        }
    }
    
}
