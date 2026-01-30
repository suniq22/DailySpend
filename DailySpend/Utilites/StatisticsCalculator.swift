import Foundation


enum StatisticsCalculator {

    static func calculate(
        expenses: [Expense],
        period: StatsPeriod,
        currency: Currency,
        calendar: Calendar = .current
    ) -> StatsResult {

        let now = Date()
        let startDate: Date
        let daysCount: Double

        switch period {
        case .week:
            startDate = calendar.date(byAdding: .day, value: -6, to: calendar.startOfDay(for: now))!
            daysCount = 7

        case .month:
            let comps = calendar.dateComponents([.year, .month], from: now)
            startDate = calendar.date(from: comps)!
            let diff = calendar.dateComponents(
                [.day],
                from: startDate,
                to: calendar.startOfDay(for: now)
            ).day ?? 0
            daysCount = Double(diff + 1)
            
        case .allTime:
            guard let firstExpenseDate = expenses.first?.date else {
                startDate = calendar.startOfDay(for: now)
                daysCount = 1
                break
            }
            startDate = calendar.startOfDay(for: firstExpenseDate)
            let diff = calendar.dateComponents(
                [.day],
                from: startDate,
                to: calendar.startOfDay(for: now)
            ).day ?? 0
            daysCount = Double(diff)

        }
        
        let filtered = expenses
            .filter { $0.date >= startDate }
            .filter { $0.amount.currency == currency }

        let total = filtered.reduce(0) { $0 + $1.amount.value }
        let avg = daysCount > 0 ? total / daysCount : 0
        
        
        let grouped = Dictionary(grouping: filtered, by: { $0.category })

        let breakdown = grouped.map { category, expenses in
            let sum = expenses.reduce(0) { $0 + $1.amount.value }
            let percent = total > 0 ? sum / total : 0
            return BreakdownItem(category: category, amount: sum, percent: percent)
        }
        .sorted { $0.amount > $1.amount }
        
        let topCategory = breakdown.first?.category
        
        let summary = StatsSummary(total: total, avgPerDay: avg, topCategory: topCategory)
        
        return StatsResult(summary: summary, items: breakdown)
    }
}
