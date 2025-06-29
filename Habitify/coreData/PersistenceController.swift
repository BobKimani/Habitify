import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // Preview instance for SwiftUI canvas previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

        let viewContext = controller.container.viewContext
        for i in 0..<3 {
            let newHabit = Habit(context: viewContext)
            newHabit.id = UUID()
            newHabit.title = "Sample Habit \(i)"
            newHabit.category = "Health"
            newHabit.createdAt = Date()
            newHabit.isArchived = false
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error: \(nsError), \(nsError.userInfo)")
        }

        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "HabitifyModel") // ✅ name must match your .xcdatamodeld file

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error loading store: \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
