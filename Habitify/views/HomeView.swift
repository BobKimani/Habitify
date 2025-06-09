import SwiftUI

struct HomeView: View {
    @State private var completedHabits: Set<String> = ["Drink 8 Glasses Water"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header
                    HStack {
                        Label("Hi, Alex", systemImage: "person.circle")
                            .font(.headline)

                        Spacer()

                        HStack(spacing: 16) {
                            Image(systemName: "bell")
                            Image(systemName: "info.circle")
                        }
                        .font(.title3)
                    }
                    .padding(.horizontal)

                    // Date & Quote
                    VStack(alignment: .leading, spacing: 4) {
                        Text(formattedDate())
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("“Small steps lead to big changes”")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)

                    // Habit Sections
                    HabitView(
                        title: "Health",
                        habits: ["Morning Exercise", "Drink 8 Glasses Water"],
                        completedHabits: $completedHabits
                    )

                    HabitView(
                        title: "Productivity",
                        icon: "bolt",
                        habits: ["Deep Work - 2 hours", "No Social Media"],
                        completedHabits: $completedHabits
                    )

                    HabitView(
                        title: "Personal Development",
                        icon: "brain.head.profile",
                        habits: ["Read 30 Minutes", "Meditation"],
                        completedHabits: $completedHabits
                    )

                    Spacer(minLength: 30)
                }
                .padding(.top)
            }
            .navigationTitle("Habitify")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: Date())
    }
    
}

#Preview {
    NavigationStack {
        BottomNavView()
    }
}
