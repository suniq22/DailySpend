import UIKit

final class StatisticsView: GradientView {

    let tableView = UITableView(frame: .zero, style: .plain)

    var onPeriodChanged: ((Int) -> Void)?
    var onCurrencyChanged: ((Int) -> Void)?

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

    private let mainLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        $0.textColor = .white.withAlphaComponent(0.7)
        $0.text = "Statistics"
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let statisticsImageView: UIImageView = {
        $0.image = UIImage(named: "Statistics")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    private let periodContainerView = StatisticsView.makeGlassContainer()
    private let currencyContainerView = StatisticsView.makeGlassContainer()

    private let periodSegment: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Last week", "Last month", "All time"])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private let currencySegment: UISegmentedControl = {
        let control = UISegmentedControl(items: ["EUR", "USD", "BYN", "RUB"])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private let cardsStack: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 12
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())

    private let totalCard = StatisticsCardView(style: .green)
    private let avgCard = StatisticsCardView(style: .blue)
    private let topCard = StatisticsCardView(style: .orange)

    private let breakdownTitle: UILabel = {
        $0.text = "Category Breakdown"
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
        $0.textColor = .white.withAlphaComponent(0.65)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let tableContainerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white.withAlphaComponent(0.25)
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = true
        return $0
    }(UIView())

    private var tableHeightConstraint: NSLayoutConstraint?

    private let footerLabel: UILabel = {
        $0.text = "Showing data in selected currency."
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .white.withAlphaComponent(0.45)
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupScrollLayout()
        setupHeader()
        setupSegments()
        setupCards()
        setupBreakdown()

        configureSegmentsAppearance()
        wireActions()
    }

    required init?(coder: NSCoder) { fatalError("") }

    private func setupScrollLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentContainerView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            contentContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentContainerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentContainerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentContainerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            contentContainerView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }

    private func setupHeader() {
        contentContainerView.addSubview(mainLabel)
        contentContainerView.addSubview(statisticsImageView)

        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: -15),
            mainLabel.centerXAnchor.constraint(equalTo: contentContainerView.centerXAnchor),

            statisticsImageView.centerYAnchor.constraint(equalTo: mainLabel.centerYAnchor),
            statisticsImageView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -10),
            statisticsImageView.heightAnchor.constraint(equalToConstant: 90),
            statisticsImageView.widthAnchor.constraint(equalToConstant: 90)
        ])
    }

    private func setupSegments() {
        contentContainerView.addSubview(periodContainerView)
        periodContainerView.addSubview(periodSegment)

        contentContainerView.addSubview(currencyContainerView)
        currencyContainerView.addSubview(currencySegment)

        NSLayoutConstraint.activate([
            periodContainerView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 24),
            periodContainerView.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 16),
            periodContainerView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -16),

            periodSegment.topAnchor.constraint(equalTo: periodContainerView.topAnchor, constant: 8),
            periodSegment.bottomAnchor.constraint(equalTo: periodContainerView.bottomAnchor, constant: -8),
            periodSegment.leadingAnchor.constraint(equalTo: periodContainerView.leadingAnchor, constant: 8),
            periodSegment.trailingAnchor.constraint(equalTo: periodContainerView.trailingAnchor, constant: -8),

            currencyContainerView.topAnchor.constraint(equalTo: periodContainerView.bottomAnchor, constant: 12),
            currencyContainerView.leadingAnchor.constraint(equalTo: periodContainerView.leadingAnchor),
            currencyContainerView.trailingAnchor.constraint(equalTo: periodContainerView.trailingAnchor),

            currencySegment.topAnchor.constraint(equalTo: currencyContainerView.topAnchor, constant: 8),
            currencySegment.bottomAnchor.constraint(equalTo: currencyContainerView.bottomAnchor, constant: -8),
            currencySegment.leadingAnchor.constraint(equalTo: currencyContainerView.leadingAnchor, constant: 8),
            currencySegment.trailingAnchor.constraint(equalTo: currencyContainerView.trailingAnchor, constant: -8)
        ])
    }

    private func setupCards() {
        contentContainerView.addSubview(cardsStack)
        cardsStack.addArrangedSubview(totalCard)
        cardsStack.addArrangedSubview(avgCard)
        cardsStack.addArrangedSubview(topCard)

        NSLayoutConstraint.activate([
            cardsStack.topAnchor.constraint(equalTo: currencyContainerView.bottomAnchor, constant: 16),
            cardsStack.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 16),
            cardsStack.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -16),
            cardsStack.heightAnchor.constraint(equalToConstant: 140)
        ])
    }

    private func setupBreakdown() {
        contentContainerView.addSubview(breakdownTitle)
        contentContainerView.addSubview(tableContainerView)
        tableContainerView.addSubview(tableView)
        contentContainerView.addSubview(footerLabel)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false

        tableHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 1)
        tableHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            breakdownTitle.topAnchor.constraint(equalTo: cardsStack.bottomAnchor, constant: 18),
            breakdownTitle.leadingAnchor.constraint(equalTo: cardsStack.leadingAnchor),
            breakdownTitle.trailingAnchor.constraint(lessThanOrEqualTo: cardsStack.trailingAnchor),

            tableContainerView.topAnchor.constraint(equalTo: breakdownTitle.bottomAnchor, constant: 10),
            tableContainerView.leadingAnchor.constraint(equalTo: cardsStack.leadingAnchor),
            tableContainerView.trailingAnchor.constraint(equalTo: cardsStack.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: tableContainerView.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: tableContainerView.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: tableContainerView.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: tableContainerView.bottomAnchor, constant: -10),

            footerLabel.topAnchor.constraint(equalTo: tableContainerView.bottomAnchor, constant: 14),
            footerLabel.leadingAnchor.constraint(equalTo: tableContainerView.leadingAnchor),
            footerLabel.trailingAnchor.constraint(equalTo: tableContainerView.trailingAnchor),
            footerLabel.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor, constant: -18)
        ])
    }

    func updateTableHeight() {
        tableView.layoutIfNeeded()
        tableHeightConstraint?.constant = tableView.contentSize.height
    }

    func setSelectedCurrencyIndex(_ index: Int) {
        currencySegment.selectedSegmentIndex = index
    }

    private func wireActions() {
        periodSegment.addTarget(self, action: #selector(periodChanged), for: .valueChanged)
        currencySegment.addTarget(self, action: #selector(currencyChanged), for: .valueChanged)
    }

    @objc private func periodChanged() {
        onPeriodChanged?(periodSegment.selectedSegmentIndex)
    }

    @objc private func currencyChanged() {
        onCurrencyChanged?(currencySegment.selectedSegmentIndex)
    }

    private func configureSegmentsAppearance() {
        periodSegment.selectedSegmentTintColor = .white.withAlphaComponent(0.25)
        currencySegment.selectedSegmentTintColor = .white.withAlphaComponent(0.25)

        let normalAttrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.6),
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
        ]
        let selectedAttrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.9),
            .font: UIFont.systemFont(ofSize: 14, weight: .bold)
        ]
        periodSegment.setTitleTextAttributes(normalAttrs, for: .normal)
        periodSegment.setTitleTextAttributes(selectedAttrs, for: .selected)
        currencySegment.setTitleTextAttributes(normalAttrs, for: .normal)
        currencySegment.setTitleTextAttributes(selectedAttrs, for: .selected)
    }
    
    func configureCards(total: String, avg: String, topCategory: ExpenseCategory) {
        topCard.configure(title: "Top Category", value: "\(topCategory.rawValue) \(topCategory.icon)", icon: "info.square.fill")
        totalCard.configure(title: "Total for the period", value: total, icon: "dollarsign.gauge.chart.leftthird.topthird.rightthird")
        avgCard.configure(title: "Agerage per day", value: avg, icon: "calendar")
    }
    
    private static func makeGlassContainer() -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white.withAlphaComponent(0.25)
        v.layer.cornerRadius = 18
        v.clipsToBounds = true
        return v
    }
}
