enum ExpenseCategory: String, Codable, CaseIterable {
    case food = "Food"
    case transport = "Transport"
    case entertainment = "Entertainment"
    case clothes = "Clothes"
    case gifts = "Gifts"
    case subscriptions = "Subscriptions"
    case selfcare = "Selfcare"
    case housing = "Housing"
    case study = "Study"
    case healthcare = "Healthcare"
    case other = "Other"
    
    var title: String {
        switch self {
        case .food: return "Food"
        case .transport: return "Transport"
        case .entertainment: return "Entertainment"
        case .clothes: return "Clothes"
        case .gifts: return "Gifts"
        case .subscriptions: return "Subscriptions"
        case .selfcare: return "Selfcare"
        case .housing: return "Housing"
        case .study: return "Study"
        case .healthcare: return "Healthcare"
        case .other: return "Other"
        }
    }
    
    var icon: String {
        switch self {
        case .food: return "🍕"
        case .transport: return "🚕"
        case .entertainment: return "🔥"
        case .clothes: return "👕"
        case .gifts: return "🎁"
        case .subscriptions: return "📆"
        case .selfcare: return "🧴"
        case .housing: return "🏡"
        case .study: return "📚"
        case .healthcare: return "🏥"
        case .other: return "❓"
        }
    }
    
    var displayTitle: String {
        "\(icon) \(title)"
    }
}
