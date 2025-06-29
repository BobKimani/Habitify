import SwiftUI

struct BottomNavView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var achievementsViewModel: AchievementsViewModel

    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Today", systemImage: "house")
            }

            NavigationStack {
                ProgressView(context: viewContext)
            }
            .tabItem {
                Label("Progress", systemImage: "chart.bar.fill")
            }

            NavigationStack {
                AchievementsView(viewModel: achievementsViewModel)
                    .environmentObject(authViewModel)
            }
            .tabItem {
                Label("Achievements", systemImage: "trophy.fill")
            }

            NavigationStack {
                ProfileView()
                    .environmentObject(authViewModel)
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
        }
        .accentColor(.purple)
    }
}
