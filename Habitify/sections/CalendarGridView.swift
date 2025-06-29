import SwiftUI

struct CalendarGridView: View {
    let completionDates: Set<Date>
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 7)

    private let calendar = Calendar.current
    private let currentMonth: Date = Date()
    private var daysInMonth: [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: currentMonth),
              let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth)) else {
            return []
        }

        return range.compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: monthStart)
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(monthTitle)
                .font(.headline)
                .padding(.bottom, 4)

            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(weekdays, id: \ .self) { day in
                    Text(day)
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                }

                ForEach(daysInMonth, id: \ .self) { day in
                    let isCompleted = completionDates.contains(day.startOfDay)

                    Circle()
                        .fill(isCompleted ? Color.purple : Color.gray.opacity(0.2))
                        .frame(width: 32, height: 32)
                        .overlay(
                            Text("\(calendar.component(.day, from: day))")
                                .font(.caption)
                                .foregroundColor(isCompleted ? .white : .primary)
                        )
                }
            }
        }
        .padding(.top, 8)
    }

    private var weekdays: [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        return formatter.shortWeekdaySymbols
    }

    private var monthTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth)
    }
}

#Preview {
    CalendarGridView(completionDates: [Date()])
}
