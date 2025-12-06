import UIKit

class MainViewController: UIViewController {
    private let store: ExpenseStore
    private let avatarView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage.tamplier
        $0.clipsToBounds = true
        $0.backgroundColor = .red
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    private let addExpenseButtonContainer: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        return $0
    }(UIView())
    private let mainLabel: UILabel = {
        $0.text = "Todays's total spending"
        $0.font = UIFont.boldSystemFont(ofSize: 40)
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    private var backgroundGradient: CAGradientLayer = {
        return $0
    }(CAGradientLayer())
    private var addExpenseButtonGradient: CAGradientLayer = {
        return $0
    }(CAGradientLayer())
    private let expenseLabel: UILabel = {
        $0.text = "BYN"
        $0.font = UIFont.boldSystemFont(ofSize: 65)
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    private let menuButton: UIButton = {
        $0.setImage(UIImage(systemName:"line.horizontal.3")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 28)), for: .normal)
        $0.tintColor = .black
        $0.backgroundColor = .gray.withAlphaComponent(0.2)
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGeneralUI()
        setupAvatarView()
        setupBackgroundGradient()
        setupMenuButton()
        setupMainLabel()
        setupExpenseLabel()
        store.change = {[weak self] in
            self?.updateTotalExpense()
        }
        updateTotalExpense()
        setupAddExpenseButton()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarView.layer.cornerRadius = avatarView.frame.width / 2
        menuButton.layer.cornerRadius = menuButton.frame.height / 2
        addExpenseButtonContainer.layer.cornerRadius = 20
        backgroundGradient.frame = view.bounds
        addExpenseButtonGradient.frame = addExpenseButton.bounds
    }
    private func setupGeneralUI() {
        view.backgroundColor = .clear
    }
    private func setupAvatarView() {

        view.addSubview(avatarView)
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            avatarView.widthAnchor.constraint(equalToConstant: 55),
            avatarView.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    private func setupExpenseLabel() {
        view.addSubview(expenseLabel)
    NSLayoutConstraint.activate([
        expenseLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 30),
        expenseLabel.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
        expenseLabel.trailingAnchor.constraint(equalTo: mainLabel.trailingAnchor)
    ])
    }
    private func setupBackgroundGradient() {
        backgroundGradient = GradientFactory.gradientBackground()
        view.layer.insertSublayer(backgroundGradient, at: 0)
    }
    private func setupMenuButton() {
        view.addSubview(menuButton)
        NSLayoutConstraint.activate([
            menuButton.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            menuButton.heightAnchor.constraint(equalToConstant: 55),
            menuButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    private func setupMainLabel() {
        view.addSubview(mainLabel)
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: menuButton.bottomAnchor, constant: 55),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    private func setupAddExpenseButton() {
        view.addSubview(addExpenseButtonContainer)
        addExpenseButtonGradient = GradientFactory.gradientBackground()
        addExpenseButtonContainer.layer.insertSublayer(addExpenseButtonGradient, at: 0)
        addExpenseButtonContainer.addSubview(addExpenseButton)
        addExpenseButton.addTarget(self, action: #selector(pressDown), for: .touchDown)
        addExpenseButton.addTarget(self, action: #selector(pressUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        addExpenseButton.addTarget(self, action: #selector(addExpense), for: .touchUpInside)
        addExpenseButton.addTarget(self, action: #selector(pressDown), for: .touchDragEnter)
        addExpenseButton.addTarget(self, action: #selector(pressUp), for: .touchDragExit)

        NSLayoutConstraint.activate([
            addExpenseButtonContainer.topAnchor.constraint(equalTo: expenseLabel.bottomAnchor, constant: 50),
            addExpenseButtonContainer.leadingAnchor.constraint(equalTo: expenseLabel.leadingAnchor),
            addExpenseButtonContainer.trailingAnchor.constraint(equalTo: expenseLabel.trailingAnchor),
            addExpenseButtonContainer.heightAnchor.constraint(equalToConstant: 65),
            addExpenseButton.topAnchor.constraint(equalTo: addExpenseButtonContainer.topAnchor),
            addExpenseButton.bottomAnchor.constraint(equalTo: addExpenseButtonContainer.bottomAnchor),
            addExpenseButton.leadingAnchor.constraint(equalTo: addExpenseButtonContainer.leadingAnchor),
            addExpenseButton.trailingAnchor.constraint(equalTo: addExpenseButtonContainer.trailingAnchor)
        ])
    }
    private func updateTotalExpense() {
        expenseLabel.text = "\(store.todayTotal()) BYN"
    }
    @objc private func addExpense() {
    }
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
    init(store: ExpenseStore) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

