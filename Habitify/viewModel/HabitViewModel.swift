import Foundation
import CoreData

class HabitViewModel: ObservableObject {
    private let viewContext: NSManagedObjectContext
    private let achievementViewModel: AchievementsViewModel

    init(context: NSManagedObjectContext, achievementViewModel: AchievementsViewModel) {
        self.viewContext = context
        self.achievementViewModel = achievementViewModel
    }

    func isCompletedToday(_ habit: Habit) -> Bool {
        let request: NSFetchRequest<HabitCompletion> = HabitCompletion.fetchRequest()
        request.predicate = NSPredicate(
            format: "habit == %@ AND date >= %@ AND date < %@",
            habit,
            Calendar.current.startOfDay(for: Date()) as NSDate,
            Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))! as NSDate
        )
        request.fetchLimit = 1

        do {
            return try viewContext.count(for: request) > 0
        } catch {
            print("Error checking completion: \(error.localizedDescription)")
            return false
        }
    }

    func toggle(_ habit: Habit, onSuccess: @escaping () -> Void, onUnlock: @escaping () -> Void) {
        if isCompletedToday(habit) {
            deleteTodayCompletion(for: habit, onSuccess: onSuccess)
        } else {
            let completion = HabitCompletion(context: viewContext)
            completion.id = UUID()
            completion.date = Date()
            completion.habit = habit

            do {
                try viewContext.save()

                //Trigger achievement logic
                achievementViewModel.createAchievement(for: habit, ifMissingWithTitle: "Completed \(habit.title ?? "Habit")")
                achievementViewModel.unlockAchievement(for: habit)

                onUnlock()
                onSuccess()
                print("Marked complete: \(habit.title ?? "")")
            } catch {
                print("Failed to save completion: \(error.localizedDescription)")
            }
        }
    }

    private func deleteTodayCompletion(for habit: Habit, onSuccess: @escaping () -> Void) {
        let request: NSFetchRequest<HabitCompletion> = HabitCompletion.fetchRequest()
        request.predicate = NSPredicate(
            format: "habit == %@ AND date >= %@ AND date < %@",
            habit,
            Calendar.current.startOfDay(for: Date()) as NSDate,
            Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))! as NSDate
        )

        do {
            let results = try viewContext.fetch(request)
            for completion in results {
                viewContext.delete(completion)
            }
            try viewContext.save()
            achievementViewModel.removeAchievement(for: habit)
            onSuccess()
            print("Deleted today's completion for \(habit.title ?? "")")
        } catch {
            print("Failed to delete completion: \(error.localizedDescription)")
        }
    }
}
