import Foundation
import CoreData
import Combine

class ProgressViewModel: ObservableObject {
    @Published var weeklyStats: [String: Int] = [:]
    @Published var totalCompletionsThisWeek: Int = 0
    @Published var categoryDistribution: [String: Int] = [:]
    @Published var completionDates: Set<Date> = []
    @Published var bestStreak: Int = 0
    @Published var currentStreak: Int = 0

    private let viewContext: NSManagedObjectContext
    private let calendar = Calendar.current
    private var cancellable: AnyCancellable?

    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchStats()

        // Refresh on Core Data changes
        cancellable = NotificationCenter.default
            .publisher(for: .NSManagedObjectContextDidSave, object: context)
            .sink { [weak self] _ in
                self?.fetchStats()
            }
    }

    func fetchStats() {
        let request: NSFetchRequest<HabitCompletion> = HabitCompletion.fetchRequest()

        do {
            let results = try viewContext.fetch(request)

            guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: Date()) else { return }

            let thisWeek = results.filter { completion in
                guard let date = completion.date else { return false }
                return weekInterval.contains(date)
            }

            totalCompletionsThisWeek = thisWeek.count
            weeklyStats = Dictionary(grouping: thisWeek) { $0.habit?.category ?? "Other" }.mapValues { $0.count }
            categoryDistribution = Dictionary(grouping: results) { $0.habit?.category ?? "Other" }.mapValues { $0.count }
            completionDates = Set(results.compactMap { $0.date?.startOfDay })
            calculateStreaks(from: results.compactMap { $0.date })

        } catch {
            print("Error fetching: \(error.localizedDescription)")
        }
    }

    private func calculateStreaks(from dates: [Date]) {
        let sorted = Set(dates.map { $0.startOfDay }).sorted(by: >)
        var currentStreakCount = 0
        var maxStreakCount = 0
        var previousDate: Date?

        for date in sorted {
            if let prev = previousDate, calendar.date(byAdding: .day, value: -1, to: prev) == date {
                currentStreakCount += 1
            } else {
                currentStreakCount = 1
            }
            maxStreakCount = max(maxStreakCount, currentStreakCount)
            previousDate = date
        }

        currentStreak = currentStreakCount
        bestStreak = maxStreakCount
    }
}
