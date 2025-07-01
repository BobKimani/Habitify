import SwiftUI

struct AchievementsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: AchievementsViewModel
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    header

                    Text("Your Achievements")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    if viewModel.achievements.isEmpty {
                        Text("No achievements yet.")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    } else {
                        VStack(spacing: 16) {
                            ForEach(viewModel.achievements) { achievement in
                                AchievementCard(
                                    title: achievement.title ?? "Untitled",
                                    description: achievement.desc ?? "",
                                    unlocked: achievement.unlocked
                                )
                            }
                        }
                        .padding(.horizontal)
                    }

                    Spacer(minLength: 30)
                }
                .padding(.top)
            }
            .navigationTitle("Achievements")
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
}

