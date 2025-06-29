import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct HabitifyApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var profileViewModel = ProfileViewModel()

    init() {
        FirebaseApp.configure()

        // Force logout on every fresh app launch
        do {
            try Auth.auth().signOut()
            print("Forced sign-out on launch")
        } catch {
            print("Error signing out on launch: \(error.localizedDescription)")
        }
    }

    var body: some Scene {
        WindowGroup {
            NavContainer()
                .environmentObject(authViewModel)
                .environmentObject(profileViewModel)
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                .preferredColorScheme(profileViewModel.colorScheme)
                .onAppear {
                    profileViewModel.loadSettings()
                }
        }
    }
}
