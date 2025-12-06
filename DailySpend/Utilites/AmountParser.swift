import Foundation
enum AmountParser {
    static func parse(_ input: String) throws -> Double {
        var text = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else {
            throw AddExpenseValidationError.emptyAmount
        }
        text = text.replacingOccurrences(of: ",", with: ".")
        
        guard let amount = Double(text) else {
            throw AddExpenseValidationError.invalidAmount
        }
        return amount
    }
}
