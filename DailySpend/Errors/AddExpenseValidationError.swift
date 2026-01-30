import Foundation

enum AddExpenseValidationError: LocalizedError {
    case emptyTitle
    case emptyAmount
    case invalidAmount

    var errorDescription: String? {
        switch self {
        case .emptyTitle:
            return "Please enter a title."
        case .emptyAmount:
            return "Please enter a value."
        case .invalidAmount:
            return "Please enter a valid value."
        }
    }
}
