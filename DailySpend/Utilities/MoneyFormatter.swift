import Foundation

enum MoneyFormatter {
    
    static func string(_ value: Double, currency: Currency) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        let number = nf.string(from: NSNumber(value: value)) ?? "0.00"
        return "\(number) \(currency.symbol)"
    }

    static func percent(_ value: Double) -> String {
        let p = Int((value * 100).rounded())
        return "\(p)%"
    }
}
