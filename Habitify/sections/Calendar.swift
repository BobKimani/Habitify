import SwiftUI

struct CalendarView: View {
    let days = ["S", "M", "T", "W", "T", "F", "S"]
    let currentMonthDates = Array(1...31)

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("May 2025")
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "chevron.left")
                Image(systemName: "chevron.right")
            }

            HStack {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(currentMonthDates, id: \.self) { day in
                    Text("\(day)")
                        .frame(maxWidth: .infinity)
                        .padding(6)
                        .background(day == 2 || day == 4 || day == 9 ? Color.purple.opacity(0.2) : Color.clear)
                        .clipShape(Circle())
                }
            }
        }
        .font(.subheadline)
    }
}

#Preview {
    CalendarView()
}
