import SwiftUI

struct BottomNavView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Today", systemImage: "house")
                }

            ProgressView() 
                .tabItem {
                    Label("Progress", systemImage: "chart.bar.fill")
                }

            AchievementsView()
                .tabItem {
                    Label("Achievements", systemImage: "trophy.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .accentColor(.purple)
    }
}

#Preview {
    BottomNavView()
}
