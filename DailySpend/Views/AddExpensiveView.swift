import UIKit
final class AddExpenseView: GradientView {
    
    private var categories: [ExpenseCategory] = []
    private var selectedCategory: ExpenseCategory = .food
    private var currencyString: String = "$"
    
    var onClose: (() -> Void)?
    var onSave: ((AddExpenseInput) -> Void)?
    let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let cardView: UIView = {
        $0.backgroundColor = UIColor.white.withAlphaComponent(0.80)
        $0.layer.cornerRadius = 26
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let headerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let headerLabel: UILabel = {
        $0.text = "Add Expense"
        $0.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        $0.textAlignment = .center
        $0.textColor = .purple
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let closeButton: UIButton = {
        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium)
        let image = UIImage(systemName: "xmark.circle", withConfiguration: config)
        $0.setImage(image, for: .normal)
        $0.tintColor = .purple
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    private let separator: UIView = {
        $0.backgroundColor = UIColor.purple.withAlphaComponent(0.15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let amountView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let amountTextField: UITextField = {
        $0.textColor = .purple
        $0.attributedPlaceholder = NSAttributedString(
            string: "0,00",
            attributes: [
                .foregroundColor: UIColor.lightGray
            ]
        )
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    private let currencyLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.textAlignment = .right
        $0.textColor = .purple
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let hintLabel: UILabel = {
        $0.text = "Enter amount"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.textAlignment = .right
        $0.textColor = .purple
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let categoryView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let categoryLabel: UILabel = {
        $0.text = "Category"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .purple
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let titleView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let titleLabel: UILabel = {
        $0.text = "Title"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .purple
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let titleTextField: UITextField = {
        $0.textAlignment = .left
        $0.attributedPlaceholder = NSAttributedString(
            string: "Enter title",
            attributes: [
                .foregroundColor: UIColor.lightGray
            ]
        )
        $0.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.textColor = .purple
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    private let saveButton: UIButton = {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("Save", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    private let saveButtonContainer: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private var saveButtonGradient: CAGradientLayer = {
        return $0
    }(CAGradientLayer())
    
    private let contentStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 20
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())

    private func setupCardView() {
        contentView.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupHeaderView(){
        contentStackView.addArrangedSubview(headerView)
        headerView.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }
    
    private func setupCloseButton(){
        headerView.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupHeaderLabel(){
        headerView.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }
    
    private func setupSeparator() {
        cardView.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            separator.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupAmountView() {
        contentStackView.addArrangedSubview(amountView)
    }
    
    private func setupAmountTextField(){
        amountView.addSubview(amountTextField)
        NSLayoutConstraint.activate([
            amountTextField.topAnchor.constraint(equalTo: amountView.topAnchor, constant: 10),
            amountTextField.leadingAnchor.constraint(equalTo: amountView.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupHintLabel() {
        amountView.addSubview(hintLabel)
        NSLayoutConstraint.activate([
            hintLabel.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 5),
            hintLabel.leadingAnchor.constraint(equalTo: amountTextField.leadingAnchor),
            hintLabel.bottomAnchor.constraint(equalTo: amountView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupCurrencyLabel() {
        amountView.addSubview(currencyLabel)
        currencyLabel.text = currencyString
        NSLayoutConstraint.activate([
            currencyLabel.centerYAnchor.constraint(equalTo: amountTextField.centerYAnchor),
            currencyLabel.trailingAnchor.constraint(equalTo: amountView.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupCategoryView() {
        contentStackView.addArrangedSubview(categoryView)

    }
    private func setupCategoryLabel() {
        categoryView.addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: categoryView.topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: categoryView.leadingAnchor)
        ])
    }
    
    private func setupCategoryCollectionView() {
        categoryView.addSubview(categoryCollectionView)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
        categoryCollectionView.layer.cornerRadius = 12
        categoryCollectionView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            categoryCollectionView.leadingAnchor.constraint(equalTo: categoryView.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: categoryView.trailingAnchor),
            categoryCollectionView.bottomAnchor.constraint(equalTo: categoryView.bottomAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 120)
            ])

    }
    
    private func setupTitleView() {
        contentStackView.addArrangedSubview(titleView)
    }
    
    private func setupTitleLabel() {
        titleView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor)
        ])
    }
    
    private func setupTitleTextField() {
        titleView.addSubview(titleTextField)
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        titleTextField.leftView = leftPadding
        titleTextField.leftViewMode = .always
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            titleTextField.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: titleView.bottomAnchor)
        ])
    }
    
    private func setupSaveButton() {
        contentStackView.addArrangedSubview(saveButtonContainer)
        saveButtonContainer.addSubview(saveButton)
        saveButtonGradient = GradientFactory.gradientBackground()
        saveButtonContainer.layer.insertSublayer(saveButtonGradient, at: 0)
        saveButtonContainer.layer.cornerRadius = 10
        saveButtonContainer.layer.masksToBounds = true
        saveButton.addTarget(self, action: #selector(pressDown), for: .touchDown)
        saveButton.addTarget(self, action: #selector(pressUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(pressDown), for: .touchDragEnter)
        saveButton.addTarget(self, action: #selector(pressUp), for: .touchDragExit)
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: saveButtonContainer.topAnchor),
            saveButton.leadingAnchor.constraint(equalTo: saveButtonContainer.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: saveButtonContainer.trailingAnchor),
            saveButton.bottomAnchor.constraint(equalTo: saveButtonContainer.bottomAnchor)
        ])
    }
    
    private func setupStackView(){
        cardView.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 25),
            contentStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10),
            contentStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor)
            ])
    }
    
    private func setupScrollView(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)

        ])
    }
    
    private func setupKeyboardDone() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(title: "Done",
                                   style: .done,
                                   target: self,
                                   action: #selector(doneTapped))
        let flex = UIBarButtonItem(systemItem: .flexibleSpace)
        toolbar.items = [flex, done]
        amountTextField.inputAccessoryView = toolbar
        titleTextField.inputAccessoryView = toolbar
    }
    
    func scrollOffset(height: CGFloat) {
        let viewInset = frame.height - cardView.frame.maxY
        scrollView.contentOffset.y = height - viewInset + 5
    }
    
    @objc private func pressDown() {
        UIView.animate(withDuration: 0.07) {
            self.saveButtonContainer.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.saveButton.setTitleColor(.gray, for: .normal)
        }
    }
    
    @objc private func pressUp() {
        UIView.animate(withDuration: 0.07) {
            self.saveButtonContainer.transform = .identity
            self.saveButton.setTitleColor(.white, for: .normal)
        }
    }
    
    @objc private func close() { onClose?() }

    @objc private func save() { onSave?(currentInput()) }
    
    @objc private func doneTapped() {
        endEditing(true)
    }
    
    private func currentInput() -> AddExpenseInput {
        AddExpenseInput(
            title: titleTextField.text ?? "",
            value: amountTextField.text ?? "",
            category: selectedCategory
        )
    }
    
    func render(categories: [ExpenseCategory], selectedCategory: ExpenseCategory, currencyString: String) {
        self.categories = categories
        self.selectedCategory = selectedCategory
        categoryCollectionView.reloadData()
    }
    
    func renderCurrencyString(_ currencyString: String) {
        self.currencyString = currencyString
        currencyLabel.text = currencyString
    }
    
    func layoutGradient() {
        saveButtonGradient.frame = saveButtonContainer.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        setupCardView()
        setupStackView()
        setupHeaderView()
        setupHeaderLabel()
        setupCloseButton()
        setupSeparator()
        setupAmountView()
        setupAmountTextField()
        setupHintLabel()
        setupCurrencyLabel()
        setupCategoryView()
        setupCategoryLabel()
        setupCategoryCollectionView()
        setupTitleView()
        setupTitleLabel()
        setupTitleTextField()
        setupKeyboardDone()
        setupSaveButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}

extension AddExpenseView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 33)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
    }
    
}

extension AddExpenseView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath)
        guard let categoryCell = cell as? CategoryCell else { return cell }
        categoryCell.configure(category: categories[indexPath.item])
        return cell
    }
    
}
