import UIKit

final class MainView: GradientView {

    var addExpenseButtonAction: (() -> Void)?

    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alwaysBounceVertical = true
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
        return $0
    }(UIScrollView())

    private let contentContainerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        return $0
    }(UIView())

    private let moneyImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "Money")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    private let addExpenseButtonContainer: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        return $0
    }(UIView())

    private let mainLabel: UILabel = {
        $0.text = "Today's total spending"
        $0.font = UIFont.boldSystemFont(ofSize: 40)
        $0.textColor = .white.withAlphaComponent(0.7)
        $0.numberOfLines = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private var addExpenseButtonGradient: CAGradientLayer = {
        return $0
    }(CAGradientLayer())

    private let expenseLabel: UILabel = {
        $0.text = "BYN"
        $0.font = UIFont.boldSystemFont(ofSize: 50)
        $0.textColor = UIColor.white.withAlphaComponent(0.7)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let addExpenseButton: UIButton = {
        $0.setImage(UIImage(systemName:"plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 28)), for: .normal)
        $0.tintColor = .white
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.setTitle("Add expense", for: .normal)
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())

    private let lastExpenseImageContainer: UIView = {
        $0.backgroundColor = .blue.withAlphaComponent(0.1)
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private let lastExpenseTitle: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 26)
        $0.textColor = UIColor.white.withAlphaComponent(0.7)
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        return $0
    }(UILabel())

    private let lastExpenseAmount: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.textColor = UIColor.white.withAlphaComponent(0.7)
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        $0.attributedText = NSAttributedString(
            string: "0,00 BYN",
            attributes: [
                .font: $0.font!,
                .baselineOffset: 5
            ]
        )
        return $0
    }(UILabel())

    private let lastExpenseImage: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    private let lastExpenseInfoView: UIView = {
        $0.backgroundColor = .blue.withAlphaComponent(0.2)
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private let lastExpenseLabel: UILabel = {
        $0.text = "Last expense"
        $0.textColor = .blue.withAlphaComponent(0.3)
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let lastExpenseView: UIView = {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupGeneralUI()
        setupScrollLayout()
        setupMainLabel()
        setupMoneyImageView()
        setupExpenseLabel()
        render(totalAmount: "0.00")
        setupAddExpenseButton()
        setupLastExpenseView()
        setupLastExpenseLabel()
        setupLastExpenseImageContainer()
        setupLastExpenseImage()
        setupLastExpenseInfoView()
        setupLastExpenseTitle()
        setupLastExpenseAmount()

        lastExpenseAmount.setContentHuggingPriority(.defaultHigh, for: .vertical)
        lastExpenseTitle.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    private func setupGeneralUI() {
        backgroundColor = .clear
    }

    private func setupScrollLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentContainerView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: -45),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            contentContainerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentContainerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentContainerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentContainerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),


            contentContainerView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }

    private func setupMoneyImageView() {
        contentContainerView.addSubview(moneyImageView)
        NSLayoutConstraint.activate([
            moneyImageView.centerYAnchor.constraint(equalTo: mainLabel.centerYAnchor),
            moneyImageView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -3),
            moneyImageView.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 4),
            moneyImageView.heightAnchor.constraint(equalToConstant: 95)
        ])
    }

    private func setupExpenseLabel() {
        contentContainerView.addSubview(expenseLabel)
        NSLayoutConstraint.activate([
            expenseLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 30),
            expenseLabel.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
            expenseLabel.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -30)
        ])
    }

    private func setupMainLabel() {
        contentContainerView.addSubview(mainLabel)
        NSLayoutConstraint.activate([

            mainLabel.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: 10),
            mainLabel.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 30)
        ])
    }

    private func setupAddExpenseButton() {
        contentContainerView.addSubview(addExpenseButtonContainer)

        addExpenseButtonGradient = GradientFactory.gradientBackground()
        addExpenseButtonContainer.layer.insertSublayer(addExpenseButtonGradient, at: 0)

        addExpenseButtonContainer.addSubview(addExpenseButton)

        addExpenseButton.addTarget(self, action: #selector(pressDown), for: .touchDown)
        addExpenseButton.addTarget(self, action: #selector(pressUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        addExpenseButton.addTarget(self, action: #selector(addExpense), for: .touchUpInside)
        addExpenseButton.addTarget(self, action: #selector(pressDown), for: .touchDragEnter)
        addExpenseButton.addTarget(self, action: #selector(pressUp), for: .touchDragExit)

        NSLayoutConstraint.activate([
            addExpenseButtonContainer.topAnchor.constraint(equalTo: expenseLabel.bottomAnchor, constant: 30),
            addExpenseButtonContainer.leadingAnchor.constraint(equalTo: expenseLabel.leadingAnchor),
            addExpenseButtonContainer.trailingAnchor.constraint(equalTo: expenseLabel.trailingAnchor),
            addExpenseButtonContainer.heightAnchor.constraint(equalToConstant: 65),

            addExpenseButton.topAnchor.constraint(equalTo: addExpenseButtonContainer.topAnchor),
            addExpenseButton.bottomAnchor.constraint(equalTo: addExpenseButtonContainer.bottomAnchor),
            addExpenseButton.leadingAnchor.constraint(equalTo: addExpenseButtonContainer.leadingAnchor),
            addExpenseButton.trailingAnchor.constraint(equalTo: addExpenseButtonContainer.trailingAnchor)
        ])
    }

    private func setupLastExpenseView() {
        contentContainerView.addSubview(lastExpenseView)
        NSLayoutConstraint.activate([
            lastExpenseView.topAnchor.constraint(equalTo: addExpenseButton.bottomAnchor, constant: 30),
            lastExpenseView.leadingAnchor.constraint(equalTo: addExpenseButton.leadingAnchor),
            lastExpenseView.trailingAnchor.constraint(equalTo: addExpenseButton.trailingAnchor),

            lastExpenseView.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor, constant: -25)
        ])
    }

    private func setupLastExpenseLabel() {
        lastExpenseView.addSubview(lastExpenseLabel)
        NSLayoutConstraint.activate([
            lastExpenseLabel.topAnchor.constraint(equalTo: lastExpenseView.topAnchor, constant: 5),
            lastExpenseLabel.centerXAnchor.constraint(equalTo: lastExpenseView.centerXAnchor)
        ])
    }

    private func setupLastExpenseImageContainer() {
        lastExpenseView.addSubview(lastExpenseImageContainer)
        NSLayoutConstraint.activate([
            lastExpenseImageContainer.topAnchor.constraint(equalTo: lastExpenseLabel.bottomAnchor, constant: 10),
            lastExpenseImageContainer.widthAnchor.constraint(equalTo: addExpenseButtonContainer.widthAnchor, multiplier: 0.53),
            lastExpenseImageContainer.centerXAnchor.constraint(equalTo: lastExpenseView.centerXAnchor),
            lastExpenseImageContainer.heightAnchor.constraint(equalTo: addExpenseButtonContainer.widthAnchor, multiplier: 0.53)
        ])
    }

    private func setupLastExpenseImage() {
        lastExpenseImageContainer.addSubview(lastExpenseImage)
        NSLayoutConstraint.activate([
            lastExpenseImage.centerXAnchor.constraint(equalTo: lastExpenseImageContainer.centerXAnchor),
            lastExpenseImage.leadingAnchor.constraint(equalTo: lastExpenseImageContainer.leadingAnchor, constant: 25),
            lastExpenseImage.topAnchor.constraint(equalTo: lastExpenseImageContainer.topAnchor, constant: 25),
            lastExpenseImage.bottomAnchor.constraint(equalTo: lastExpenseImageContainer.bottomAnchor, constant: -25)
        ])
    }

    private func setupLastExpenseInfoView() {
        lastExpenseView.addSubview(lastExpenseInfoView)
        NSLayoutConstraint.activate([
            lastExpenseInfoView.topAnchor.constraint(equalTo: lastExpenseImageContainer.bottomAnchor, constant: 15),
            lastExpenseInfoView.leadingAnchor.constraint(equalTo: lastExpenseView.leadingAnchor, constant: 10),
            lastExpenseInfoView.trailingAnchor.constraint(equalTo: lastExpenseView.trailingAnchor, constant: -10),
            lastExpenseInfoView.bottomAnchor.constraint(equalTo: lastExpenseView.bottomAnchor, constant: -10)
        ])
    }

    private func setupLastExpenseTitle() {
        lastExpenseInfoView.addSubview(lastExpenseTitle)
        NSLayoutConstraint.activate([
            lastExpenseTitle.topAnchor.constraint(equalTo: lastExpenseInfoView.topAnchor, constant: 5),
            lastExpenseTitle.leadingAnchor.constraint(equalTo: lastExpenseInfoView.leadingAnchor, constant: 5),
            lastExpenseTitle.trailingAnchor.constraint(equalTo: lastExpenseInfoView.trailingAnchor, constant: -5)
        ])
    }

    private func setupLastExpenseAmount() {
        lastExpenseInfoView.addSubview(lastExpenseAmount)
        NSLayoutConstraint.activate([
            lastExpenseAmount.bottomAnchor.constraint(equalTo: lastExpenseInfoView.bottomAnchor, constant: -5),
            lastExpenseAmount.leadingAnchor.constraint(equalTo: lastExpenseTitle.leadingAnchor),
            lastExpenseAmount.topAnchor.constraint(equalTo: lastExpenseTitle.bottomAnchor, constant: 5)
        ])
    }

    func layoutAddExpenseButton() {
        addExpenseButtonGradient.frame = addExpenseButtonContainer.bounds
        addExpenseButtonContainer.layer.cornerRadius = 20
    }

    func layoutlastExpenseImageContainer() {
        lastExpenseImageContainer.layer.cornerRadius = lastExpenseImageContainer.frame.height / 2
    }

    func render(totalAmount: String) {
        expenseLabel.text = "\(totalAmount)"
    }

    func renderLastExpense(title: String, amount: String, imageName: String) {
        lastExpenseImage.image = UIImage(named: imageName)
        lastExpenseTitle.text = title
        lastExpenseAmount.text = "\(amount)"
    }

    @objc private func addExpense() { addExpenseButtonAction?() }

    @objc private func pressDown() {
        UIView.animate(withDuration: 0.07) {
            self.addExpenseButtonContainer.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.addExpenseButton.setTitleColor(.gray, for: .normal)
        }
    }

    @objc private func pressUp() {
        UIView.animate(withDuration: 0.07) {
            self.addExpenseButtonContainer.transform = .identity
            self.addExpenseButton.setTitleColor(.white, for: .normal)
        }
    }
}
