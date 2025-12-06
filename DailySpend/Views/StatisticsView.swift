import UIKit

class StatisticsView: GradientView {
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
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let statisticsImageView: UIImageView = {
        $0.image = UIImage(named: "Statistics")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMainLabel()
        setupStatisticsImageView()  
    }
    
    private func setupScrollLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentContainerView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
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

    private func setupMainLabel() {
        contentContainerView.addSubview(mainLabel)
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -25),
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupStatisticsImageView() {
        contentContainerView.addSubview(statisticsImageView)
        
        NSLayoutConstraint.activate([
            statisticsImageView.centerYAnchor.constraint(equalTo: mainLabel.centerYAnchor),
            statisticsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            statisticsImageView.heightAnchor.constraint(equalToConstant: 100),
            statisticsImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}
