import Foundation
import CoreData
import SwiftUI
import Combine

class AchievementsViewModel: ObservableObject {
    @Published var achievements: [Achievement] = []

    private let context: NSManagedObjectContext
    private var cancellable: AnyCancellable?

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchAchievements()
        observeChanges()
    }

    func fetchAchievements() {
        let request: NSFetchRequest<Achievement> = Achievement.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Achievement.dateUnlocked, ascending: false)]

        do {
            achievements = try context.fetch(request)
        } catch {
            print("Failed to fetch achievements: \(error.localizedDescription)")
            achievements = []
        }
    }

    func createAchievement(for habit: Habit, ifMissingWithTitle title: String) {
        guard !hasAchievement(for: habit) else { return }

        let achievement = Achievement(context: context)
        achievement.id = UUID()
        achievement.title = title
        achievement.desc = "Completed habit \"\(habit.title ?? "Habit")\""
        achievement.unlocked = false
        achievement.habit = habit
        achievement.dateUnlocked = nil

        do {
            try context.save()
        } catch {
            print("Failed to create achievement: \(error.localizedDescription)")
        }
    }

    func unlockAchievement(for habit: Habit) {
        let request: NSFetchRequest<Achievement> = Achievement.fetchRequest()
        request.predicate = NSPredicate(format: "habit == %@", habit)

        do {
            if let achievement = try context.fetch(request).first {
                achievement.unlocked = true
                achievement.dateUnlocked = Date()
                try context.save()
            }
        } catch {
            print("Failed to unlock achievement: \(error.localizedDescription)")
        }
    }

    func removeAchievement(for habit: Habit) {
        let request: NSFetchRequest<Achievement> = Achievement.fetchRequest()
        request.predicate = NSPredicate(format: "habit == %@", habit)

        do {
            let results = try context.fetch(request)
            for achievement in results {
                context.delete(achievement)
            }
            try context.save()
        } catch {
            print("Failed to remove achievement: \(error.localizedDescription)")
        }
    }

    func hasAchievement(for habit: Habit) -> Bool {
        let request: NSFetchRequest<Achievement> = Achievement.fetchRequest()
        request.predicate = NSPredicate(format: "habit == %@", habit)
        request.fetchLimit = 1

        do {
            return try context.count(for: request) > 0
        } catch {
            return false
        }
    }

    private func observeChanges() {
        cancellable = NotificationCenter.default
            .publisher(for: .NSManagedObjectContextDidSave, object: context)
            .debounce(for: .milliseconds(100), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.fetchAchievements()
            }
    }
}
