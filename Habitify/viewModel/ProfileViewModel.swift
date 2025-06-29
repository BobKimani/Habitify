import Foundation
import SwiftUI
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    @Published var colorScheme: ColorScheme? = nil
    @Published var displayName: String = ""
    @Published var email: String = ""
    @Published var errorMessage: String?
    @Published var successMessage: String?

    // MARK: - Load Settings (Dark mode + user info)
    func loadSettings() {
        let isDark = UserDefaults.standard.bool(forKey: "isDarkMode")
        colorScheme = isDark ? .dark : .light

        if let user = Auth.auth().currentUser {
            displayName = user.displayName ?? ""
            email = user.email ?? ""
        }
    }

    // MARK: - Toggle Dark Mode
    func toggleDarkMode() {
        colorScheme = (colorScheme == .dark) ? .light : .dark
        UserDefaults.standard.set(colorScheme == .dark, forKey: "isDarkMode")
    }

    // MARK: - Update Email (with Firebase verification)
       func updateEmail(to newEmail: String, currentPassword: String) {
           guard let user = Auth.auth().currentUser, let oldEmail = user.email else {
               errorMessage = "No authenticated user."
               return
           }

           let credential = EmailAuthProvider.credential(withEmail: oldEmail, password: currentPassword)

           user.reauthenticate(with: credential) { [weak self] _, error in
               if let error = error {
                   self?.errorMessage = "Reauthentication failed: \(error.localizedDescription)"
                   self?.successMessage = nil
                   return
               }

               user.sendEmailVerification(beforeUpdatingEmail: newEmail) { error in
                   if let error = error {
                       self?.errorMessage = "Email verification failed: \(error.localizedDescription)"
                       self?.successMessage = nil
                   } else {
                       self?.successMessage = "✅ Verification email sent to \(newEmail). Confirm to complete update."
                       self?.errorMessage = nil
                   }
               }
           }
       }

       // MARK: - Update Password (requires reauth)
       func updatePassword(to newPassword: String, currentPassword: String) {
           guard let user = Auth.auth().currentUser, let email = user.email else {
               errorMessage = "User not available."
               return
           }

           let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)

           user.reauthenticate(with: credential) { [weak self] _, error in
               if let error = error {
                   self?.errorMessage = "Reauthentication failed: \(error.localizedDescription)"
                   self?.successMessage = nil
                   return
               }

               user.updatePassword(to: newPassword) { error in
                   if let error = error {
                       self?.errorMessage = "Password update failed: \(error.localizedDescription)"
                       self?.successMessage = nil
                   } else {
                       self?.successMessage = "✅ Password updated successfully."
                       self?.errorMessage = nil
                   }
               }
           }
       }
   }
