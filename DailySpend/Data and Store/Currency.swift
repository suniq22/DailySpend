enum Currency: String, Codable, CaseIterable {
    
    case eur = "EUR"
    case usd = "USD"
    case byn = "BYN"
    case rub = "RUB"
    
    var symbol: String {
        switch self {
        case .eur: return "€"
        case .usd: return "$"
        case .byn: return "Br"
        case .rub: return "₽"
        }
    }
    
    var flag: String {
        switch self {
        case .eur: return "🇪🇺"
        case .usd: return "🇺🇸"
        case .byn: return "🇧🇾"
        case .rub: return "🇷🇺"
        }
    }
}
