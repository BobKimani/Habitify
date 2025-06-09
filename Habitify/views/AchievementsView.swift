import SwiftUI

struct AchievementsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
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

                    // Title
                    Text("Your Achievements")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    // Achievement Cards
                    VStack(spacing: 16) {
                        AchievementCard(title: "7-Day Streak", description: "You completed your habits for 7 days in a row!", unlocked: true)
                        AchievementCard(title: "Early Bird", description: "Logged all habits before 9 AM.", unlocked: false)
                        AchievementCard(title: "Consistency King", description: "Maintained 90%+ consistency.", unlocked: true)
                        AchievementCard(title: "Weekend Warrior", description: "Completed all habits on a weekend.", unlocked: false)
                    }
                    .padding(.horizontal)

                    Spacer(minLength: 30)
                }
                .padding(.top)
            }
            .navigationTitle("Achievements")
        }
    }
}

#Preview {
    AchievementsView()
}
