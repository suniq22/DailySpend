import Foundation
final class SettingsStore {
    private let key = "currentCurrency"
    var onChange: [() -> Void] = []
    
    func getCurrentCurrency() -> Currency {
        guard let currencyString = UserDefaults.standard.string(forKey: key) else {
            return .byn
        }
        return Currency(rawValue: currencyString) ?? Currency.byn
    }
    
    func setCurrentCurrency(_ currency: Currency) {
        UserDefaults.standard.set(currency.rawValue, forKey: key)
        onChange.forEach { $0() }
    }
}
