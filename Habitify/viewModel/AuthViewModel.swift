import Foundation
import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String? = nil

    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?

    init(startAtWelcome: Bool = false) {
        listenToAuthState()
    }

    deinit {
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    // MARK: - Sign In
    func signIn(email: String, password: String) {
        errorMessage = nil
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
        }
    }

    // MARK: - Sign Up
    func signUp(email: String, password: String) {
        errorMessage = nil
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
        }
    }

    // MARK: - Sign Out
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isAuthenticated = false
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }

    // MARK: - Listen to Auth Changes
    private func listenToAuthState() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.user = user
            self?.isAuthenticated = user != nil
            print("Auth state changed → isAuthenticated: \(self?.isAuthenticated == true)")
        }
    }
    
    var displayName: String {
            user?.displayName ?? user?.email?.components(separatedBy: "@").first?.capitalized ?? "User"
        }
}
