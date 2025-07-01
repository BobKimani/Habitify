import SwiftUI
import CoreData

struct HabitView: View {
    var title: String
    var onToggle: () -> Void

    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var achievementViewModel: AchievementsViewModel
    @StateObject private var viewModel: HabitViewModel
    @FetchRequest private var habits: FetchedResults<Habit>

    @State private var showAchievementAlert = false
    @State private var unlockedHabitName = ""
    @State private var isExpanded = true

    init(
        title: String,
        onToggle: @escaping () -> Void,
        achievementVM: AchievementsViewModel
    ) {
        self.title = title
        self.onToggle = onToggle
        self.achievementViewModel = achievementVM

        _viewModel = StateObject(wrappedValue: HabitViewModel(
            context: PersistenceController.shared.container.viewContext,
            achievementViewModel: achievementVM
        ))

        _habits = FetchRequest<Habit>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Habit.createdAt, ascending: true)],
            predicate: NSPredicate(format: "category == %@ AND isArchived == NO", title),
            animation: .default
        )
    }

    var body: some View {
        if habits.isEmpty {
            EmptyView()
        } else {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    headerLabel
                        .padding()
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation { isExpanded.toggle() }
                        }

                    if isExpanded {
                        Divider().padding(.horizontal, 8)

                        List {
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
                                .padding(.vertical, 8)
                                .listRowBackground(Color(.systemGray6))
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            viewModel.deleteHabit(habit) {
                                                onToggle()
                                            }
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .listStyle(.plain)
                        .frame(height: CGFloat(habits.count * 60))
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.bottom, 4)
                    }
                }
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.15), radius: 2, x: 0, y: 1)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .alert("🎉 Achievement Unlocked!", isPresented: $showAchievementAlert) {
                Button("Nice!", role: .cancel) { }
            } message: {
                Text("You’ve completed \"\(unlockedHabitName)\" from the \(title) category.")
            }
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

