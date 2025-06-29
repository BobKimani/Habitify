import SwiftUI

struct AppearanceView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel

    var body: some View {
        Form {
            Toggle("Dark Mode", isOn: Binding(
                get: { profileViewModel.colorScheme == .dark },
                set: { _ in profileViewModel.toggleDarkMode() }
            ))
        }
        .navigationTitle("Appearance")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            profileViewModel.loadSettings()
        }
    }
}
