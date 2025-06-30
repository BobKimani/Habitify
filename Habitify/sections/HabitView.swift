import SwiftUI
import CoreData

struct HabitView: View {
    var title: String
    var habits: [Habit]
    var onToggle: () -> Void

    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var achievementViewModel: AchievementsViewModel
    @StateObject private var viewModel: HabitViewModel

    @State private var showAchievementAlert = false
    @State private var unlockedHabitName = ""
    @State private var isExpanded = true

    init(
        title: String,
        habits: [Habit],
        onToggle: @escaping () -> Void,
        achievementVM: AchievementsViewModel
    ) {
        self.title = title
        self.habits = habits
        self.onToggle = onToggle
        self.achievementViewModel = achievementVM
        _viewModel = StateObject(wrappedValue: HabitViewModel(
            context: PersistenceController.shared.container.viewContext,
            achievementViewModel: achievementVM
        ))
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header + Body together in one container
            VStack(alignment: .leading, spacing: 0) {
                headerLabel
                    .padding()
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation { isExpanded.toggle() }
                    }

                if isExpanded {
                    Divider()
                        .padding(.horizontal, 8)

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
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background(Color(.systemGray6))
                        .contentShape(Rectangle())
                        .contextMenu {
                            Button(role: .destructive) {
                                viewModel.deleteHabit(habit) {
                                    onToggle()
                                }
                            } label: {
                                Label("Delete Habit", systemImage: "trash")
                            }
                        }

                        if habit != habits.last {
                            Divider()
                                .padding(.horizontal, 8)
                        }
                    }
                }
            }
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .alert("🎉 Achievement Unlocked!", isPresented: $showAchievementAlert) {
            Button("Nice!", role: .cancel) { }
        } message: {
            Text("You’ve completed \"\(unlockedHabitName)\" from the \(title) category.")
        }
    }

    private var headerLabel: some View {
        HStack {
            Text("\(categoryIcon(for: title)) \(title)")
                .font(.headline)
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                .foregroundColor(.gray)
        }
    }

    private func categoryIcon(for category: String) -> String {
        switch category.lowercased() {
        case "learning": return "📚"
        case "health": return "🧘‍♂️"
        case "productivity": return "💼"
        case "wellness": return "🏃‍♂️"
        case "personal development": return "🌱"
        case "other": return "🗂"
        default: return "🔖"
        }
    }
}
