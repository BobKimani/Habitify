import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Avatar and user info
                VStack(spacing: 8) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.purple)

                    Text(authViewModel.user?.email?.components(separatedBy: "@").first?.capitalized ?? "User")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(authViewModel.user?.email ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top)

                Divider()

                // Settings Section
                SectionCard(title: "Settings") {
                    NavigationLink(destination: AppearanceView()) {
                        ProfileRow(icon: "paintbrush", label: "Appearance")
                    }
                    ProfileRow(icon: "bell", label: "Notifications")
                    ProfileRow(icon: "lock", label: "Privacy")
                }

                // Account Section
                SectionCard(title: "Account") {
                    NavigationLink(destination: EditProfileView()) {
                        ProfileRow(icon: "person", label: "Edit Profile")
                    }

                    Button {
                        authViewModel.signOut()
                    } label: {
                        ProfileRow(icon: "arrow.right.square", label: "Logout", isDestructive: true)
                    }
                }

                Spacer(minLength: 40)
            }
            .padding()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(AuthViewModel())
    }
}
