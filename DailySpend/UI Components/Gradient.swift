import UIKit

enum GradientFactory {
    
    static func gradientBackground() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        let topColor = UIColor(red: 0.0, green: 0.0, blue: 0.78, alpha: 1.0)
        let bottomColor = UIColor(red: 0.98, green: 0.99, blue: 1.0, alpha: 1.0)

        let colors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        gradient.colors = colors
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradient
    }
}
