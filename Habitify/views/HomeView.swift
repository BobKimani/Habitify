import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var achievementVM = AchievementsViewModel(context: PersistenceController.shared.container.viewContext)
    @EnvironmentObject var authViewModel: AuthViewModel


    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.createdAt, ascending: true)],
        predicate: NSPredicate(format: "isArchived == NO"),
        animation: .default
    )
    private var habits: FetchedResults<Habit>

    @State private var showAddHabitSheet = false
    @State private var refreshToggle = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header

                // Quote
                VStack(alignment: .leading, spacing: 4) {
                    Text(formattedDate())
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("“Small steps lead to big changes”")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                // Grouped Habits by Category
                ForEach(groupedHabits.keys.sorted(), id: \.self) { category in
                    HabitView(
                        title: category,
                        habits: groupedHabits[category] ?? [],
                        onToggle: {
                            refreshToggle.toggle()
                        },
                        achievementVM: achievementVM
                    )
                }

                Spacer(minLength: 30)
            }
            .padding(.top)
        }
        .navigationTitle("Habitify") // ✅ Will now display
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddHabitSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddHabitSheet) {
            AddHabitView()
                .environment(\.managedObjectContext, viewContext)
        }
    }

    private var header: some View {
        HStack {
            Label("Hi, \(authViewModel.displayName)", systemImage: "person.circle")
                .font(.headline)

            Spacer()

            HStack(spacing: 16) {
                Image(systemName: "bell")
                Image(systemName: "info.circle")
            }
            .font(.title3)
        }
        .padding(.horizontal)
    }

    private var groupedHabits: [String: [Habit]] {
        Dictionary(grouping: habits) { $0.category ?? "Other" }
    }

    private func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: Date())
    }
}
