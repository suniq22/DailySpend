import UIKit
class GradientView: UIView {
    private let backgroundGradient = GradientFactory.gradientBackground()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.insertSublayer(backgroundGradient, at: 0)
    }

    required init?(coder: NSCoder) { fatalError("") }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundGradient.frame = bounds
    }
}

