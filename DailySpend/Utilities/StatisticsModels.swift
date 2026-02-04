enum StatsPeriod: CaseIterable {
    case week
    case month
    case allTime
}

struct StatsSummary {
    let total: Double
    let avgPerDay: Double
    let topCategory: ExpenseCategory?
}

struct BreakdownItem {
    let category: ExpenseCategory
    let amount: Double
    let percent: Double
}

struct StatsResult {
    let summary: StatsSummary
    let items: [BreakdownItem]
}

