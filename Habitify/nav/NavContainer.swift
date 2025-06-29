import SwiftUI

struct NavContainer: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var authViewModel: AuthViewModel

    @StateObject private var achievementsViewModel = AchievementsViewModel(
        context: PersistenceController.shared.container.viewContext
    )

    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                BottomNavView(
                    authViewModel: authViewModel,
                    achievementsViewModel: achievementsViewModel
                )
                .environment(\.managedObjectContext, viewContext)
            } else {
                AuthFlowView()
                    .environmentObject(authViewModel)
            }
        }
    }
}

