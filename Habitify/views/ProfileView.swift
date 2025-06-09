import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Avatar
                    VStack(spacing: 8) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.purple)

                        Text("Alex Kimani")
                            .font(.title2)
                            .fontWeight(.semibold)

                        Text("alexkimani@email.com")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top)

                    Divider()

                    // Preferences / Settings
                    SectionCard(title: "Settings") {
                        ProfileRow(icon: "bell", label: "Notifications")
                        ProfileRow(icon: "lock", label: "Privacy")
                        ProfileRow(icon: "paintbrush", label: "Appearance")
                    }

                    SectionCard(title: "Account") {
                        ProfileRow(icon: "person", label: "Edit Profile")
                        ProfileRow(icon: "arrow.right.square", label: "Logout", isDestructive: true)
                    }

                    Spacer(minLength: 40)
                }
                .padding()
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
