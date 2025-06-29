import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel

    enum EditOption: String, CaseIterable {
        case email = "Change Email"
        case password = "Change Password"
    }

    @State private var selectedOption: EditOption = .email

    // Inputs
    @State private var newEmail: String = ""
    @State private var newPassword: String = ""
    @State private var currentPassword: String = ""

    var body: some View {
        Form {
            // Mode Selector
            Section {
                Picker("Edit Option", selection: $selectedOption) {
                    ForEach(EditOption.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
            }

            // Email Form
            if selectedOption == .email {
                Section(header: Text("Change Email")) {
                    TextField("New Email", text: $newEmail)
                        .keyboardType(.emailAddress)
                    SecureField("Current Password", text: $currentPassword)

                    Button("Update Email") {
                        profileViewModel.updateEmail(to: newEmail, currentPassword: currentPassword)
                    }
                }
            }

            // Password Form
            if selectedOption == .password {
                Section(header: Text("Change Password")) {
                    SecureField("New Password", text: $newPassword)
                    SecureField("Current Password", text: $currentPassword)

                    Button("Update Password") {
                        profileViewModel.updatePassword(to: newPassword, currentPassword: currentPassword)
                    }
                }
            }

            // Feedback
            if let success = profileViewModel.successMessage {
                Text(success)
                    .foregroundColor(.green)
            }

            if let error = profileViewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Edit Account")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            newEmail = profileViewModel.email
        }
    }
}
