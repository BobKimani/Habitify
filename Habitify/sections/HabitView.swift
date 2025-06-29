import SwiftUI
import CoreData

struct HabitView: View {
    var title: String
    var icon: String = "heart.fill"
    var habits: [Habit]
    var onToggle: () -> Void

    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var achievementViewModel: AchievementsViewModel
    @StateObject private var viewModel: HabitViewModel

    @State private var showAchievementAlert = false
    @State private var unlockedHabitName = ""

    init(
        title: String,
        icon: String = "heart.fill",
        habits: [Habit],
        onToggle: @escaping () -> Void,
        achievementVM: AchievementsViewModel
    ) {
        self.title = title
        self.icon = icon
        self.habits = habits
        self.onToggle = onToggle
        self.achievementViewModel = achievementVM
        _viewModel = StateObject(wrappedValue: HabitViewModel(
            context: PersistenceController.shared.container.viewContext,
            achievementViewModel: achievementVM
        ))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label(title, systemImage: icon)
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
            }

            ForEach(habits, id: \.objectID) { habit in
                HStack {
                    Text(habit.title ?? "Untitled")
                        .foregroundColor(.primary)
                    Spacer()
                    Button(action: {
                        viewModel.toggle(habit, onSuccess: {
                            onToggle()
                        }, onUnlock: {
                            unlockedHabitName = habit.title ?? "Habit"
                            showAchievementAlert = true
                            //Ensure achievements are tracked
                            achievementViewModel.createAchievement(
                                for: habit,
                                ifMissingWithTitle: "Completed \(habit.title ?? "Habit")"
                            )
                            achievementViewModel.unlockAchievement(for: habit)
                        })
                    }) {
                        Image(systemName: viewModel.isCompletedToday(habit) ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(viewModel.isCompletedToday(habit) ? .purple : .gray)
                            .imageScale(.large)
                    }
                }
                .padding(.vertical, 8)
                .contentShape(Rectangle())
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
        .alert("🎉 Achievement Unlocked!", isPresented: $showAchievementAlert) {
            Button("Nice!", role: .cancel) { }
        } message: {
            Text("You’ve completed \"\(unlockedHabitName)\" from the \(title) category.")
        }
    }
}
